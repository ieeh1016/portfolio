import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/scroll_animations.dart';
import '../widgets/blob_background.dart';
import '../widgets/animated_nav_bar.dart';
import '../widgets/scroll_progress_indicator.dart';
import '../widgets/mobile_nav_drawer.dart';
import '../widgets/link_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _heroCtrl;
  late AnimationController _arrowCtrl;
  final Map<String, GlobalKey> _sectionKeys = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<int> _expandedCareerIndices = {};

  bool get _isMobile => MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _heroCtrl = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    );
    _arrowCtrl = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _heroCtrl.forward();
    });

    for (final id in ['about', 'skills', 'career', 'education', 'contact']) {
      _sectionKeys[id] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroCtrl.dispose();
    _arrowCtrl.dispose();
    super.dispose();
  }

  void _scrollToSection(String id) {
    final key = _sectionKeys[id];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  double get _maxWidth {
    final w = MediaQuery.of(context).size.width;
    if (w > 1200) return 900;
    if (w > 800) return 760;
    return w - 48;
  }

  Widget _constrained(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _isMobile ? 24 : 40),
          child: child,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {Duration delay = Duration.zero, GlobalKey? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          delay: delay,
          offset: const Offset(0, 50),
          child: Text(
            title,
            style: GoogleFonts.syne(textStyle: Theme.of(context).textTheme.headlineMedium),
          ),
        ),
        const SizedBox(height: 12),
        LineReveal(
          color: AppTheme.primary,
          height: 2,
          maxWidth: 60,
          delay: delay + const Duration(milliseconds: 200),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _isMobile
          ? MobileNavDrawer(
              items: const [
                NavItem(id: 'about', label: '소개', icon: Icons.person_outline),
                NavItem(id: 'skills', label: '기술', icon: Icons.code),
                NavItem(id: 'career', label: '경력', icon: Icons.work_outline),
                NavItem(id: 'education', label: '학력', icon: Icons.school_outlined),
                NavItem(id: 'contact', label: '연락처', icon: Icons.contact_page_outlined),
              ],
              onItemTap: _scrollToSection,
              onClose: () => _scaffoldKey.currentState?.closeEndDrawer(),
            )
          : null,
      body: Stack(
        children: [
          Positioned.fill(child: BlobBackground(child: SizedBox.expand())),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHero(context),
                _buildStats(context),
                const SizedBox(height: 120),
                _buildAbout(context),
                const SizedBox(height: 120),
                _buildSkills(context),
                const SizedBox(height: 120),
                _buildCareer(context),
                const SizedBox(height: 120),
                _buildEducation(context),
                const SizedBox(height: 120),
                _buildCerts(context),
                const SizedBox(height: 120),
                _buildAwards(context),
                const SizedBox(height: 120),
                _buildActivities(context),
                const SizedBox(height: 120),
                _buildContact(context),
                const SizedBox(height: 60),
                _buildFooter(context),
              ],
            ),
          ),
          Positioned(
            top: 0, left: 0, right: 0,
            child: AnimatedNavBar(
              scrollController: _scrollController,
              onSectionTap: _scrollToSection,
              sectionKeys: _sectionKeys,
              isMobile: _isMobile,
            ),
          ),
          ScrollProgressIndicator(scrollController: _scrollController),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  // HERO - 풀스크린, 타이핑 이름, 패럴랙스
  // ══════════════════════════════════════
  Widget _buildHero(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final nameSize = _isMobile ? 48.0 : 72.0;
    final name = PortfolioData.name;

    final nameAnim = CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.0, 0.30));
    final tagAnim = CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.30, 0.50, curve: Curves.easeOut));
    final subAnim = CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.45, 0.65, curve: Curves.easeOut));
    final lineAnim = CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.55, 0.75, curve: Curves.easeOut));
    final arrowAnim = CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.75, 0.95, curve: Curves.easeOut));

    return SizedBox(
      height: screenH,
      child: AnimatedBuilder(
        animation: Listenable.merge([_heroCtrl, _scrollController]),
        builder: (_, __) {
          final scroll = _scrollController.hasClients ? _scrollController.offset : 0.0;
          final fadeOut = (1 - scroll / (screenH * 0.35)).clamp(0.0, 1.0);
          final parallax = scroll * 0.35;
          final chars = (name.length * nameAnim.value).ceil().clamp(0, name.length);
          final visibleName = name.substring(0, chars);
          final cursor = nameAnim.value > 0 && nameAnim.value < 1.0 ? '│' : '';

          return Opacity(
            opacity: fadeOut,
            child: Transform.translate(
              offset: Offset(0, -parallax),
              child: _constrained(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이름 - 타이핑 (세련된 타이포 + 은은한 그림자)
                  Text(
                    '$visibleName$cursor',
                    style: GoogleFonts.syne(
                      fontSize: nameSize,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                      letterSpacing: -1.5,
                      height: 1.08,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 가벼운 인사 - 인용 스타일 (좌측 악센트 라인)
                  Opacity(
                    opacity: tagAnim.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - tagAnim.value)),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: AppTheme.primary.withValues(alpha: 0.35),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          PortfolioData.heroGreeting,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textTertiary,
                            fontSize: _isMobile ? 15 : 17,
                            height: 1.55,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 태그라인 - 위계 강조
                  Opacity(
                    opacity: tagAnim.value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - tagAnim.value)),
                      child: Text(
                        PortfolioData.tagline,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.textSecondary,
                          fontSize: _isMobile ? 18 : 22,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // 악센트 라인 (둥근 끝, 2px)
                  Opacity(
                    opacity: lineAnim.value,
                    child: Container(
                      height: 2,
                      width: (80 * lineAnim.value).clamp(0.0, 120),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                  SizedBox(height: screenH * 0.14),
                  // 스크롤 인디케이터 - 미니멀
                  Opacity(
                    opacity: arrowAnim.value * fadeOut,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'SCROLL',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.textTertiary.withValues(alpha: 0.9),
                              letterSpacing: 5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedBuilder(
                            animation: _arrowCtrl,
                            builder: (_, __) => Transform.translate(
                              offset: Offset(0, 6 * _arrowCtrl.value),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppTheme.primary.withValues(alpha: 0.85),
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  // ══════════════════════════════════════
  // STATS - 카운트업 숫자
  // ══════════════════════════════════════
  Widget _buildStats(BuildContext context) {
    final numStyle = GoogleFonts.syne(
      fontSize: _isMobile ? 36 : 48,
      fontWeight: FontWeight.w700,
      color: AppTheme.primary,
    );
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: _isMobile ? 13 : 15);

    final items = [
      _StatData(3, '+', '년 경력'),
      _StatData(700, '만+', '누적 사용자'),
      _StatData(4, '+', '프로젝트'),
    ];

    return Container(
      color: AppTheme.surfaceElevated.withValues(alpha: 0.8),
      padding: EdgeInsets.symmetric(vertical: _isMobile ? 48 : 80),
      child: _constrained(
        _isMobile
            ? Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) const SizedBox(height: 36),
                    _buildStatItem(items[i], numStyle, labelStyle, Duration(milliseconds: 150 * i)),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < items.length; i++)
                    _buildStatItem(items[i], numStyle, labelStyle, Duration(milliseconds: 200 * i)),
                ],
              ),
      ),
    );
  }

  Widget _buildStatItem(_StatData data, TextStyle? numStyle, TextStyle? labelStyle, Duration delay) {
    return ScrollReveal(
      delay: delay,
      offset: const Offset(0, 50),
      child: Column(
        children: [
          CountUpText(end: data.value, suffix: data.suffix, style: numStyle, delay: delay),
          const SizedBox(height: 4),
          Text(data.label, style: labelStyle),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  // ABOUT - 카드형 + 연락처
  // ══════════════════════════════════════
  Widget _buildAbout(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('소개', key: _sectionKeys['about']),
        ScrollReveal(
          delay: Duration.zero,
          offset: const Offset(0, 40),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(_isMobile ? 24 : 32),
            decoration: BoxDecoration(
              color: AppTheme.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.person_outline_rounded, color: AppTheme.primary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '${PortfolioData.companyName} ${PortfolioData.position}으로\n${PortfolioData.roleSummary}을 담당하고 있습니다.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: _isMobile ? 15 : 16,
                          fontWeight: FontWeight.w500,
                          height: 1.65,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  height: 1,
                  color: Colors.black.withValues(alpha: 0.06),
                ),
                const SizedBox(height: 20),
                Text(
                  '연락처',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildContactChip(Icons.phone_outlined, PortfolioData.phone, () => _launchTel(PortfolioData.phone)),
                    const SizedBox(width: 12),
                    _buildContactChip(Icons.email_outlined, PortfolioData.email, () => _launchMail(PortfolioData.email)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildContactChip(IconData icon, String text, VoidCallback onTap) {
    return _HoverContactChip(icon: icon, text: text, onTap: onTap);
  }

  // ══════════════════════════════════════
  // SKILLS - 카테고리별 그룹 + 스크롤 리빌 애니메이션
  // ══════════════════════════════════════
  Widget _buildSkills(BuildContext context) {
    final categoryLabels = PortfolioData.skillsByCategory.keys.toList();
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('기술 스택', key: _sectionKeys['skills']),
        ScrollReveal(
          delay: Duration.zero,
          offset: const Offset(0, 45),
          duration: const Duration(milliseconds: 600),
          child: Text(
            PortfolioData.highlightsSummary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: 28),
        for (var c = 0; c < categoryLabels.length; c++) ...[
          ScrollReveal(
            delay: Duration(milliseconds: 80 + 120 * c),
            offset: const Offset(0, 45),
            duration: const Duration(milliseconds: 550),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                categoryLabels[c],
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textTertiary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var i = 0; i < (PortfolioData.skillsByCategory[categoryLabels[c]] ?? []).length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 80 + 120 * c + 50 * i),
                  offset: const Offset(0, 45),
                  duration: const Duration(milliseconds: 500),
                  child: _HoverSkillChip(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        (PortfolioData.skillsByCategory[categoryLabels[c]] ?? [])[i],
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (c < categoryLabels.length - 1) const SizedBox(height: 20),
        ],
      ],
    ));
  }

  // ══════════════════════════════════════
  // CAREER - 타임라인 카드
  // ══════════════════════════════════════
  Widget _buildCareer(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('경력', key: _sectionKeys['career']),
        // 회사 헤더 (로고: assets/ktaltimedia.PNG)
        ScrollReveal(
          offset: const Offset(0, 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  child: Image.asset(
                    'assets/ktaltimedia.PNG',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.primary.withValues(alpha: 0.12),
                      child: Icon(Icons.business, color: AppTheme.primary, size: 28),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(PortfolioData.companyName, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${PortfolioData.position} · ${PortfolioData.careerPeriod}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        // 프로젝트 카드 (카드형 + 여백)
        for (var i = 0; i < PortfolioData.projects.length; i++) ...[
          _buildProjectCard(PortfolioData.projects[i], i),
          if (i < PortfolioData.projects.length - 1) const SizedBox(height: 32),
        ],
      ],
    ));
  }

  /// 프로젝트별 기술 스택을 칩으로 표시 (아키텍처 + tech 문자열 파싱)
  Widget _buildProjectTechChips(ProjectItem project, {bool expanded = false}) {
    final chips = <String>[
      project.architecture,
      ...project.tech.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty),
    ];
    final fontSize = expanded ? 13.0 : 12.0;
    final padding = expanded
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips.map((label) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: AppTheme.primary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectCard(ProjectItem project, int index) {
    final delayMs = 200 * index;
    final isExpanded = _expandedCareerIndices.contains(index);
    return ScrollReveal(
      delay: Duration(milliseconds: delayMs),
      offset: const Offset(0, 50),
      child: Container(
        padding: EdgeInsets.all(_isMobile ? 20 : 28),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더: 제목 + 기간 + 플랫폼
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    project.period,
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${project.platform} · ${project.language}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            // 역할 (라벨 없이 한 줄)
            Text(
              project.role,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: 20),
            // 요약
            Text(
              project.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            const SizedBox(height: 24),
            // 펼침: 담당 업무 · 성과 · 기술 스택
            if (isExpanded) ...[
              Text(
                '담당 업무',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              ...project.tasks.map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '·',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          task,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.emoji_events_outlined, size: 18, color: AppTheme.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        project.achievement,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '기술 스택',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              _buildProjectTechChips(project, expanded: true),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () => setState(() => _expandedCareerIndices.remove(index)),
                icon: const Icon(Icons.expand_less, size: 20),
                label: const Text('접기'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ] else
              TextButton.icon(
                onPressed: () => setState(() => _expandedCareerIndices.add(index)),
                icon: const Icon(Icons.expand_more, size: 20),
                label: const Text('업무 · 성과 보기'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════
  // EDUCATION
  // ══════════════════════════════════════
  Widget _buildEducation(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('학력', key: _sectionKeys['education']),
        ScrollReveal(
          offset: const Offset(0, 50),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(PortfolioData.schoolName,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'GPA ${PortfolioData.gpa}',
                        style: TextStyle(color: AppTheme.primary, fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('${PortfolioData.major} · ${PortfolioData.educationPeriod} 졸업', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                LineReveal(color: Colors.black.withValues(alpha: 0.06), height: 1),
                const SizedBox(height: 16),
                ScrollReveal(
                  delay: const Duration(milliseconds: 300),
                  offset: const Offset(0, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(PortfolioData.thesisJournal, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(PortfolioData.thesisTitle, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Text(PortfolioData.graduationWork, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  // ══════════════════════════════════════
  // CERTIFICATES
  // ══════════════════════════════════════
  Widget _buildCerts(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('자격증 · 어학'),
        for (var i = 0; i < PortfolioData.certificates.length; i++)
          ScrollReveal(
            delay: Duration(milliseconds: 150 * i),
            offset: const Offset(0, 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    ),
                    child: Icon(Icons.verified, size: 18, color: AppTheme.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(PortfolioData.certificates[i].name, style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          '${PortfolioData.certificates[i].issuer} · ${PortfolioData.certificates[i].date}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        ScrollReveal(
          delay: Duration(milliseconds: 150 * PortfolioData.certificates.length),
          offset: const Offset(0, 50),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                ),
                child: Icon(Icons.language, size: 18, color: AppTheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(PortfolioData.opic, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
        ),
      ],
    ));
  }

  // ══════════════════════════════════════
  // AWARDS
  // ══════════════════════════════════════
  Widget _buildAwards(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('수상'),
        for (var i = 0; i < PortfolioData.awards.length; i++)
          ScrollReveal(
            delay: Duration(milliseconds: 200 * i),
            offset: const Offset(0, 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    ),
                    child: Icon(Icons.emoji_events, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(PortfolioData.awards[i].title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          '${PortfolioData.awards[i].issuer} · ${PortfolioData.awards[i].year}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (PortfolioData.awards[i].detail != null) ...[
                          const SizedBox(height: 4),
                          Text(PortfolioData.awards[i].detail!, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ));
  }

  // ══════════════════════════════════════
  // ACTIVITIES
  // ══════════════════════════════════════
  Widget _buildActivities(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('인턴 · 대외활동'),
        for (var i = 0; i < PortfolioData.activities.length; i++)
          ScrollReveal(
            delay: Duration(milliseconds: 200 * i),
            offset: const Offset(0, 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            PortfolioData.activities[i].type,
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${PortfolioData.activities[i].period} · ${PortfolioData.activities[i].duration}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(PortfolioData.activities[i].title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(PortfolioData.activities[i].description, style: Theme.of(context).textTheme.bodyMedium),
                    if (PortfolioData.activities[i].link != null) ...[
                      const SizedBox(height: 12),
                      LinkButton(label: '앱 보기', url: PortfolioData.activities[i].link!, icon: Icons.open_in_new),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    ));
  }

  // ══════════════════════════════════════
  // CONTACT
  // ══════════════════════════════════════
  Widget _buildContact(BuildContext context) {
    return _constrained(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('연락처 · 링크', key: _sectionKeys['contact']),
        ScrollReveal(
          offset: const Offset(0, 50),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactRow(Icons.phone_outlined, '연락처', PortfolioData.phone, () => _launchTel(PortfolioData.phone)),
                _buildContactRow(Icons.email_outlined, '이메일', PortfolioData.email, () => _launchMail(PortfolioData.email)),
                _buildContactRow(Icons.location_on_outlined, '주소', PortfolioData.address, null),
                const SizedBox(height: 16),
                LineReveal(color: Colors.black.withValues(alpha: 0.06), height: 1, delay: const Duration(milliseconds: 300)),
                const SizedBox(height: 20),
                ScrollReveal(
                  delay: const Duration(milliseconds: 400),
                  offset: const Offset(0, 50),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      LinkButton(label: '노션', url: PortfolioData.notionUrl, icon: Icons.description),
                      LinkButton(label: 'GitHub', url: PortfolioData.githubUrl, icon: Icons.code),
                      LinkButton(label: '티스토리', url: PortfolioData.tistoryUrl, icon: Icons.article),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildContactRow(IconData icon, String label, String value, VoidCallback? onTap) {
    final content = Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            ),
            child: Icon(icon, size: 16, color: AppTheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
                Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
    return onTap != null ? GestureDetector(onTap: onTap, child: content) : content;
  }

  // ══════════════════════════════════════
  // FOOTER
  // ══════════════════════════════════════
  Widget _buildFooter(BuildContext context) {
    return ScrollReveal(
      offset: const Offset(0, 50),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            '${PortfolioData.name} · ${DateTime.now().year}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textTertiary,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  // ═══ Helpers ═══
  Future<void> _launchTel(String phone) async {
    final uri = Uri.parse('tel:${phone.replaceAll('-', '')}');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchMail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

class _HoverContactChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _HoverContactChip({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  State<_HoverContactChip> createState() => _HoverContactChipState();
}

class _HoverContactChipState extends State<_HoverContactChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hover ? AppTheme.primary : AppTheme.primary.withValues(alpha: 0.3),
              width: _hover ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: _hover
                ? [BoxShadow(color: AppTheme.primary.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 2))]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: AppTheme.primary),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverSkillChip extends StatefulWidget {
  final Widget child;

  const _HoverSkillChip({required this.child});

  @override
  State<_HoverSkillChip> createState() => _HoverSkillChipState();
}

class _HoverSkillChipState extends State<_HoverSkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class _StatData {
  final double value;
  final String suffix;
  final String label;
  const _StatData(this.value, this.suffix, this.label);
}
