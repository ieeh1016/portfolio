/// 이력서 PDF 기반 포트폴리오 데이터
class PortfolioData {
  // 기본 정보
  static const String name = '현영우';
  static const String tagline = '도전하고 발전하는 개발자 현영우입니다.';
  static const String birth = '1998년 (만 28세)';
  static const String phone = '010-7122-0450';
  static const String email = 'ieeh0122@naver.com';
  static const String address = '경기 화성시 영천동';

  // 링크
  static const String notionUrl =
      'https://dot-stove-a0a.notion.site/YoungWoo-Hyun-e9216017272744b4818ab76dd874bdab?pvs=4';
  static const String githubUrl = 'https://github.com/ieeh1016';
  static const String tistoryUrl = 'https://youngdroidstudy.tistory.com/';
  static const String whatnowPlayStore =
      'https://play.google.com/store/apps/details?id=com.depromeet.whatnow';

  // 스킬 태그
  static const List<String> skills = [
    'Android',
    'Kotlin',
    'Java',
    'Dart',
    'Flutter',
    'Git',
    'Jira',
    'Android Studio',
    'SQL',
    'Confluence',
    'Jetpack Compose',
    'Clean Architecture',
    'MVVM',
    'Hilt',
    'Coroutines',
  ];

  // 학력
  static const String schoolName = '경기대학교 (수원)';
  static const String major = '컴퓨터공학부 컴퓨터공학전공';
  static const String educationPeriod = '2016. 03 ~ 2023. 02';
  static const String gpa = '3.98 / 4.5';
  static const String thesisTitle =
      '컴퓨팅적 사고능력의 향상을 위한 아동 교육용 모바일 블록코딩 게임 연구 개발';
  static const String thesisJournal = '한국정보기술학회 논문 채택';
  static const String graduationWork =
      '유니티엔진을 이용한 안드로이드 모바일 교육용 블록코딩 게임 개발 - 플레이 스토어 출시';

  // 경력 요약
  static const String companyName = '㈜KT Altimedia';
  static const String careerPeriod = '2022. 10 ~ 재직 중';
  static const String careerTotal = '총 3년 5개월';
  static const String position = 'KT Altimedia AX/DX 사업본부 Client팀 연구원';
  static const String roleSummary = 'KT IPTV Android App 개발 및 Flutter 앱 개발';

  // 경력 프로젝트 상세
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'HCN / Skylife 키즈랜드 그룹사 OTT 앱 고도화',
      period: '2022.10 ~ 2023.02',
      platform: 'Android App',
      summary:
          '기존 KT 키즈랜드를 그룹사(HCN, Skylife)에 맞춰 Android Native OTT 앱으로 확장 적용',
      role: '마이메뉴 및 검색 기능 관련 오류 수정 및 고도화',
      tasks: [
        'UI/GUI 검수에 따른 오류 수정',
        'QA 이슈 대응 및 안정성 개선',
        '검색 기능 UI 및 API 고도화',
      ],
      architecture: 'MVC',
      language: 'Java',
      tech: 'Android SDK, Retrofit, OkHttp, Glide',
      achievement: 'HCN, Skylife, KT 그룹사 대상 앱에 적용되어 누적 사용자 수 700만 명 이상 달성',
    ),
    ProjectItem(
      title: 'KT 키즈랜드 하이브리드 → Android Native 전환',
      period: '2023.01 ~ 2024.12',
      platform: 'Android App',
      summary:
          '기존 하이브리드 기반 KT 키즈랜드 앱을 Android Native로 전환하여 성능 및 UX 최적화',
      role: '마이메뉴 및 검색 메뉴 기능 전반 개발',
      tasks: [
        '마이메뉴 기능 개발 (키즈모드 설정, 플레이리스트, 즐겨찾기, 프로필 변경, 세이펜 기능)',
        '검색 기능 개발 (VOD 콘텐츠 검색, 필터, 인기/최근 검색어, 자동완성어, 트렌드 검색 기능)',
      ],
      architecture: 'Clean Architecture (Presentation / Domain / Data Layer 분리)',
      language: 'Kotlin',
      tech: 'Hilt, Jetpack Navigation, Coroutines, StateFlow, Retrofit, Coil, ExoPlayer',
      achievement:
          'Native 전환으로 기존 대비 앱 속도 30% 이상 개선. 전체 그룹사 포함 누적 사용자 수 700만 명 이상 확보',
    ),
    ProjectItem(
      title: 'KT Disney+ / Tving 요금제 개편 대응',
      period: '2024.01 ~ 2024.12',
      platform: 'Android App',
      summary: 'Disney+ 및 Tving의 요금제 인상에 따른 UI 개편 및 서비스 정책 반영',
      role: '요금제 및 부가서비스 화면 개선',
      tasks: [
        'Disney+ 요금인상 대응 UI/서비스 개편',
        'Tving 요금제 정책 변경에 따른 기능 수정 및 UI 개선',
      ],
      architecture: 'MVVM',
      language: 'Kotlin',
      tech: 'Retrofit, Glide, Android Jetpack, ViewBinding, ConstraintLayout',
      achievement: 'Disney+ 및 Tving 요금제 UI 개편 안정적 적용. 관련 부가서비스 누적 가입자 3만 명 육박',
    ),
    ProjectItem(
      title: 'Visual Vive - KT Altimedia 홈포탈 앱',
      period: '2024.11 ~ 진행 중',
      platform: 'Android TV, 모바일, 웹',
      summary:
          'KT Altimedia 자체 홈포탈 Product. 고객이 콘텐츠 모듈을 UI로 배치하고 실시간 TV 송출이 가능한 맞춤형 플랫폼',
      role: '전체 앱 아키텍처 설계 및 기능 개발 주도',
      tasks: [
        '콘텐츠 구매, DCA 연동, EPG, My메뉴, 검색 기능, VOD Detail',
        'Scroll 및 Focus 관리, Route Manager',
      ],
      architecture: 'Provider 기반 상태관리 → Riverpod 도입',
      language: 'Dart',
      tech: 'Flutter SDK, PlatformChannel, FocusTraversal, SharedPreferences, Custom RouteManager',
      achievement: 'IBC(국제방송박람회) 전시. KT 본사 제품 도입 검토 및 POC 진행',
    ),
  ];

  // 인턴·대외활동
  static const List<ActivityItem> activities = [
    ActivityItem(
      title: '디프만 - IT연합동아리',
      period: '2023. 04 ~ 2023. 07',
      duration: '4개월',
      type: '동아리',
      description:
          '안드로이드 팀장으로 디자이너 3명, 백엔드 3명과 협업하여 위치 기반 약속 앱 개발 및 구글 플레이 스토어 출시',
      link: whatnowPlayStore,
    ),
    ActivityItem(
      title: '경기대학교 SW중심대학',
      period: '2022. 03 ~ 2022. 12',
      duration: '10개월',
      type: '교내활동',
      description: 'SW상상기업 "경마블" - 가상 기업으로 안드로이드 모바일 게임 개발 및 출시',
    ),
    ActivityItem(
      title: '알로이스',
      period: '2022. 07 ~ 2022. 08',
      duration: '2개월',
      type: '인턴',
      description:
          '정부 혁신 과제 OTT 앱 인터넷 강의 시청 기능 추가, 신규 OTT 서비스 런칭 버그 수정 (Kotlin, Android)',
    ),
    ActivityItem(
      title: '스마일게이트 퓨처랩',
      period: '2022. 04 ~ 2022. 05',
      duration: '2개월',
      type: '사회활동',
      description: '스마일게이트 인디게임 창작 공모전 - 교육용 모바일 블록코딩 게임 "코딩 아일랜드" 제작 출품',
    ),
  ];

  // 자격증
  static const List<CertItem> certificates = [
    CertItem(name: '정보처리기사', issuer: '한국산업인력공단', date: '2025. 12'),
    CertItem(name: 'Azure AI-900', issuer: 'Microsoft', date: '2025. 10'),
    CertItem(name: 'SQL 개발자', issuer: '한국데이터산업진흥원', date: '2021. 10'),
  ];

  // 어학
  static const String opic = 'OPIc IM2 (취득일: 2022. 06)';

  // 수상
  static const List<AwardItem> awards = [
    AwardItem(
      title: '2022년 SW상상기업 프로젝트 프로그램 우수 사업계획서 상',
      issuer: '경기대학교 소프트웨어중심대학사업단',
      year: '2022년',
    ),
    AwardItem(
      title: '경기대학교 컴퓨터공학 캡스톤디자인 경진대회 금상',
      issuer: '경기대학교 소프트웨어중심대학사업단',
      year: '2022년',
      detail: '안드로이드 아동 교육용 모바일 블록코딩 게임 개발, 32개 팀 중 2등',
    ),
    AwardItem(
      title: '우수논문상 (동상)',
      issuer: '한국정보기술학회',
      year: '2022년',
      detail: '컴퓨팅적 사고능력의 향상을 위한 아동 교육용 모바일 논문 발표',
    ),
  ];
}

class ProjectItem {
  final String title;
  final String period;
  final String platform;
  final String summary;
  final String role;
  final List<String> tasks;
  final String architecture;
  final String language;
  final String tech;
  final String achievement;

  const ProjectItem({
    required this.title,
    required this.period,
    required this.platform,
    required this.summary,
    required this.role,
    required this.tasks,
    required this.architecture,
    required this.language,
    required this.tech,
    required this.achievement,
  });
}

class ActivityItem {
  final String title;
  final String period;
  final String duration;
  final String type;
  final String description;
  final String? link;

  const ActivityItem({
    required this.title,
    required this.period,
    required this.duration,
    required this.type,
    required this.description,
    this.link,
  });
}

class CertItem {
  final String name;
  final String issuer;
  final String date;

  const CertItem({
    required this.name,
    required this.issuer,
    required this.date,
  });
}

class AwardItem {
  final String title;
  final String issuer;
  final String year;
  final String? detail;

  const AwardItem({
    required this.title,
    required this.issuer,
    required this.year,
    this.detail,
  });
}
