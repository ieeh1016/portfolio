import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/portfolio_card.dart';
import '../widgets/link_button.dart';
import '../widgets/project_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            backgroundColor: AppTheme.background,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHero(context),
                  const SizedBox(height: 32),
                  _buildContactChips(context),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '소개', icon: Icons.person_outline),
                    child: PortfolioCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.tagline,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${PortfolioData.careerTotal} · ${PortfolioData.companyName} ${PortfolioData.position}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '스킬', icon: Icons.code),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: PortfolioData.skills
                          .map((s) => Chip(
                                label: Text(s),
                                backgroundColor: AppTheme.surfaceLight,
                              ))
                          .toList(),
                    ),
                  ),
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '경력', icon: Icons.work_outline),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PortfolioCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      PortfolioData.companyName,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryLight,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      PortfolioData.careerPeriod,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                PortfolioData.position,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                PortfolioData.roleSummary,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...PortfolioData.projects.map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ProjectCard(project: p),
                            )),
                      ],
                    ),
                  ),
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '학력', icon: Icons.school_outlined),
                    child: PortfolioCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.schoolName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${PortfolioData.major} · ${PortfolioData.educationPeriod} 졸업',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '학점 ${PortfolioData.gpa}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
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
                    header: const SectionHeader(title: '자격증 · 어학', icon: Icons.card_membership),
                    child: Column(
                      children: [
                        PortfolioCard(
                          child: Column(
                            children: [
                              ...PortfolioData.certificates.map(
                                (c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.verified, size: 20, color: AppTheme.primary),
                                      const SizedBox(width: 10),
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
                              const Divider(height: 1),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.language, size: 20, color: AppTheme.primary),
                                  const SizedBox(width: 10),
                                  Text(PortfolioData.opic, style: Theme.of(context).textTheme.bodyMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '수상', icon: Icons.emoji_events_outlined),
                    child: PortfolioCard(
                      child: Column(
                        children: [
                          for (var i = 0; i < PortfolioData.awards.length; i++)
                            Padding(
                              padding: EdgeInsets.only(bottom: i < PortfolioData.awards.length - 1 ? 14 : 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(PortfolioData.awards[i].title, style: Theme.of(context).textTheme.titleMedium),
                                  Text('${PortfolioData.awards[i].issuer} · ${PortfolioData.awards[i].year}', style: Theme.of(context).textTheme.bodySmall),
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
                  _buildSection(
                    context,
                    header: const SectionHeader(title: '인턴 · 대외활동', icon: Icons.groups_outlined),
                    child: Column(
                      children: PortfolioData.activities.map((a) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PortfolioCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        a.type,
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('${a.period} · ${a.duration}', style: Theme.of(context).textTheme.bodySmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(a.title, style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(a.description, style: Theme.of(context).textTheme.bodyMedium),
                                if (a.link != null) ...[
                                  const SizedBox(height: 8),
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
                    header: const SectionHeader(title: '연락처 · 링크', icon: Icons.contact_page_outlined),
                    child: PortfolioCard(
                      child: Column(
                        children: [
                          _ContactRow(icon: Icons.phone_outlined, label: '연락처', value: PortfolioData.phone),
                          _ContactRow(icon: Icons.email_outlined, label: '이메일', value: PortfolioData.email),
                          _ContactRow(icon: Icons.location_on_outlined, label: '주소', value: PortfolioData.address),
                          const Divider(height: 24),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              LinkButton(label: '노션 포트폴리오', url: PortfolioData.notionUrl, icon: Icons.description),
                              LinkButton(label: 'GitHub', url: PortfolioData.githubUrl, icon: Icons.code),
                              LinkButton(label: '티스토리', url: PortfolioData.tistoryUrl, icon: Icons.article),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          PortfolioData.tagline,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          PortfolioData.birth,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildContactChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _ContactChip(icon: Icons.phone, text: PortfolioData.phone, onTap: () => _launchTel(PortfolioData.phone)),
          const SizedBox(width: 8),
          _ContactChip(icon: Icons.email, text: PortfolioData.email, onTap: () => _launchMail(PortfolioData.email)),
        ],
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

  Widget _buildSection(BuildContext context, {required Widget header, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [header, child],
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ContactChip({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.surfaceLight,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppTheme.primary),
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary)),
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

  const _ContactRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
