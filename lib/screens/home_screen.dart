import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/portfolio_card.dart';
import '../widgets/animated_section.dart';
import '../widgets/animated_nav_bar.dart';
import '../widgets/scroll_progress_indicator.dart';
import '../widgets/animated_background.dart';
import '../widgets/link_button.dart';
import '../widgets/project_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  final Map<String, GlobalKey> _sectionKeys = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _sectionKeys['intro'] = GlobalKey();
    _sectionKeys['career'] = GlobalKey();
    _sectionKeys['education'] = GlobalKey();
    _sectionKeys['contact'] = GlobalKey();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  // 반응형 브레이크포인트
  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 1000;
    if (width > 800) return 800;
    return width - 48;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 0,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: getMaxWidth(context)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width > 600 ? 40 : 24,
                          vertical: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHero(context),
                            const SizedBox(height: 60),
                            _buildContactButtons(context),
                            const SizedBox(height: 80),
                            _buildSection(
                              context,
                              key: _sectionKeys['intro'],
                              delay: const Duration(milliseconds: 100),
                              header: const SectionHeader(
                                title: '소개',
                                icon: Icons.person_outline,
                              ),
                              child: PortfolioCard(
                                useGradient: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      PortfolioData.tagline,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: AppTheme.textPrimary,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '${PortfolioData.careerTotal} · ${PortfolioData.companyName}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      PortfolioData.position,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _buildSection(
                              context,
                              delay: const Duration(milliseconds: 200),
                              header: const SectionHeader(
                                title: '스킬',
                                icon: Icons.code,
                              ),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: PortfolioData.skills
                                    .map((s) => _skillChip(context, s))
                                    .toList(),
                              ),
                            ),
                            _buildSection(
                              context,
                              key: _sectionKeys['career'],
                              delay: const Duration(milliseconds: 300),
                              header: const SectionHeader(
                                title: '경력',
                                icon: Icons.work_outline,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PortfolioCard(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    PortfolioData.companyName,
                                                    style: Theme.of(context).textTheme.headlineMedium,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    PortfolioData.position,
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    PortfolioData.roleSummary,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                              decoration: BoxDecoration(
                                                gradient: AppTheme.primaryGradient,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                PortfolioData.careerPeriod,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...PortfolioData.projects.asMap().entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: ProjectCard(project: entry.value),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            _buildSection(
                              context,
                              key: _sectionKeys['education'],
                              delay: const Duration(milliseconds: 400),
                              header: const SectionHeader(
                                title: '학력',
                                icon: Icons.school_outlined,
                              ),
                              child: PortfolioCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      PortfolioData.schoolName,
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${PortfolioData.major} · ${PortfolioData.educationPeriod} 졸업',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryLight,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '학점 ${PortfolioData.gpa}',
                                        style: const TextStyle(
                                          color: AppTheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      PortfolioData.thesisJournal,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      PortfolioData.thesisTitle,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      PortfolioData.graduationWork,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _buildSection(
                              context,
                              delay: const Duration(milliseconds: 500),
                              header: const SectionHeader(
                                title: '자격증 · 어학',
                                icon: Icons.card_membership,
                              ),
                              child: PortfolioCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...PortfolioData.certificates.map(
                                      (c) => Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                gradient: AppTheme.accentGradient,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Icon(Icons.verified, size: 20, color: Colors.white),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(c.name, style: Theme.of(context).textTheme.titleMedium),
                                                  Text('${c.issuer} · ${c.date}', style: Theme.of(context).textTheme.bodySmall),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(height: 32),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: AppTheme.accentGradient,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(Icons.language, size: 20, color: Colors.white),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(PortfolioData.opic, style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _buildSection(
                              context,
                              delay: const Duration(milliseconds: 600),
                              header: const SectionHeader(
                                title: '수상',
                                icon: Icons.emoji_events_outlined,
                              ),
                              child: PortfolioCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0; i < PortfolioData.awards.length; i++) ...[
                                      if (i > 0) const SizedBox(height: 20),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              gradient: AppTheme.primaryGradient,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.emoji_events, size: 20, color: Colors.white),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  PortfolioData.awards[i].title,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                                Text(
                                                  '${PortfolioData.awards[i].issuer} · ${PortfolioData.awards[i].year}',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                                if (PortfolioData.awards[i].detail != null) ...[
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    PortfolioData.awards[i].detail!,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            _buildSection(
                              context,
                              delay: const Duration(milliseconds: 700),
                              header: const SectionHeader(
                                title: '인턴 · 대외활동',
                                icon: Icons.groups_outlined,
                              ),
                              child: Column(
                                children: PortfolioData.activities.asMap().entries.map((entry) {
                                  final a = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: PortfolioCard(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                  gradient: AppTheme.primaryGradient,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  a.type,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                '${a.period} · ${a.duration}',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(a.title, style: Theme.of(context).textTheme.titleMedium),
                                          const SizedBox(height: 4),
                                          Text(a.description, style: Theme.of(context).textTheme.bodyMedium),
                                          if (a.link != null) ...[
                                            const SizedBox(height: 12),
                                            LinkButton(label: '앱 보기', url: a.link!, icon: Icons.open_in_new),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            _buildSection(
                              context,
                              key: _sectionKeys['contact'],
                              delay: const Duration(milliseconds: 800),
                              header: const SectionHeader(
                                title: '연락처 · 링크',
                                icon: Icons.contact_page_outlined,
                              ),
                              child: PortfolioCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ContactRow(
                                      icon: Icons.phone_outlined,
                                      label: '연락처',
                                      value: PortfolioData.phone,
                                      onTap: () => _launchTel(PortfolioData.phone),
                                    ),
                                    _ContactRow(
                                      icon: Icons.email_outlined,
                                      label: '이메일',
                                      value: PortfolioData.email,
                                      onTap: () => _launchMail(PortfolioData.email),
                                    ),
                                    _ContactRow(
                                      icon: Icons.location_on_outlined,
                                      label: '주소',
                                      value: PortfolioData.address,
                                    ),
                                    const Divider(height: 32),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: [
                                        LinkButton(label: '노션', url: PortfolioData.notionUrl, icon: Icons.description),
                                        LinkButton(label: 'GitHub', url: PortfolioData.githubUrl, icon: Icons.code),
                                        LinkButton(label: '티스토리', url: PortfolioData.tistoryUrl, icon: Icons.article),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 상단 고정 네비게이션 바
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedNavBar(
              scrollController: _scrollController,
              onSectionTap: _scrollToSection,
            ),
          ),
          // 스크롤 진행 표시
          ScrollProgressIndicator(scrollController: _scrollController),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return AnimatedSection(
      delay: Duration.zero,
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          gradient: AppTheme.heroGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: AppTheme.cardShadowHover,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PortfolioData.name,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        PortfolioData.tagline,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        PortfolioData.birth,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person, size: 48, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButtons(BuildContext context) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 50),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _ContactButton(
            icon: Icons.phone,
            text: PortfolioData.phone,
            onTap: () => _launchTel(PortfolioData.phone),
          ),
          _ContactButton(
            icon: Icons.email,
            text: PortfolioData.email,
            onTap: () => _launchMail(PortfolioData.email),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    GlobalKey? key,
    required Widget header,
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return AnimatedSection(
      delay: delay,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          child,
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _skillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _launchTel(String phone) async {
    final uri = Uri.parse('tel:${phone.replaceAll('-', '')}');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchMail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _ContactButton({
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: AppTheme.primary),
              const SizedBox(width: 10),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }
}
