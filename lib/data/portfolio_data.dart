/// 이력서 PDF 기반 Portfolio 데이터
class PortfolioData {
  // 기본 정보
  static const String name = '현영우';
  /// 첫 화면 히어로용 가벼운 인사/한줄 소개
  static const String heroGreeting = '안녕하세요. Android · Flutter로 더 나은 경험을 만들고 있습니다.';
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

  // 스킬 태그 (flat, 기존 호환)
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

  /// Portfolio 한눈에 보기 (경력·성과 요약, 기존 데이터 기반)
  static const String highlightsSummary =
      'Android Native · Flutter 멀티플랫폼';

  /// 스킬 카테고리별 그룹 (Android/Flutter Portfolio 강조용, 동일 스킬만 재구성)
  static const Map<String, List<String>> skillsByCategory = {
    'Language': ['Kotlin', 'Java', 'Dart'],
    'Platform · Framework': ['Android', 'Flutter', 'Jetpack Compose'],
    'Architecture': ['Clean Architecture', 'MVVM', 'MVC'],
    'Tools · 협업': ['Hilt', 'Coroutines', 'Git', 'Jira', 'Android Studio', 'SQL', 'Confluence'],
  };

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
  static const String position = 'AX/DX 사업본부 Client팀 연구원';
  static const String roleSummary = 'KT IPTV Android App 개발 및 Flutter 앱 개발';

  // 경력 프로젝트 상세
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'HCN / Skylife 키즈랜드 그룹사 OTT 앱 고도화',
      period: '2022.10 ~ 2023.02',
      platform: 'Android App',
      summary:
      'KT 키즈랜드 서비스를 HCN, Skylife 등 그룹사 환경에 맞춰 확장한 Android Native OTT 앱 프로젝트입니다. '
          '사업자별 UI/정책 차이를 반영하면서 공통 코어 구조를 유지하고, 안정적인 런칭과 품질 확보를 목표로 했습니다.',
      role:
      '마이메뉴·검색 영역 전담 개발자로 그룹사 신규 적용 과정에서 발생한 주요 이슈 분석, 구조 개선 및 안정화 작업을 주도했습니다.',
      tasks: [
        '사업자별 UI/GUI 가이드 차이 분석 후 레이아웃·리소스 구조 정리 및 개선',
        '마이메뉴 진입 시 비정상 종료 및 프로필 전환 지연 이슈의 원인을 추적하여 비동기 처리 구조 개선 및 패치 배포',
        '검색 정렬·필터 로직 리팩토링으로 중복 노출 및 빈 결과 케이스 제거',
      ],
      architecture: '기존 MVC 구조 유지보수 및 안정화',
      language: 'Java',
      tech: 'Retrofit, OkHttp, Glide',
      achievement:
      'HCN·Skylife·KT 3개 사업자 앱에 동일 구조로 안정 적용 완료. '
          '마이메뉴·검색 관련 주요 QA 이슈 다수 해결 및 런칭 이후 안정적인 운영 환경 구축.',
    ),

    ProjectItem(
      title: 'KT 키즈랜드 하이브리드 → Android Native 전환',
      period: '2023.01 ~ 2024.12',
      platform: 'Android App',
      summary:
      'WebView 기반 하이브리드 구조의 유지보수 한계와 성능 저하 문제를 해결하기 위해 '
          'KT 키즈랜드 앱을 전면 Android Native로 재구축한 프로젝트입니다.',
      role:
      '마이메뉴·검색 도메인 기능 설계 및 구현을 주도하며, 아키텍처 분리 및 상태 관리 구조 개선을 담당했습니다.',
      tasks: [
        'Clean Architecture 도입(Presentation/Domain/Data 분리)으로 레이어 간 의존성 제거 및 테스트 용이성 확보',
        'Hilt 기반 DI 구조 설계 및 StateFlow 기반 단방향 UI 상태 관리 적용',
        '마이메뉴: 키즈모드, 플레이리스트·즐겨찾기 CRUD, 멀티 프로필 전환, 세이펜 연동 기능 Native 전면 구현',
        '검색: 통합 검색, 연령·카테고리 필터, 자동완성·트렌드 검색 API 연동 및 로컬 캐싱 구조 설계',
      ],
      architecture: 'MVVM + Clean Architecture (Presentation / Domain / Data Layer 분리)',
      language: 'Kotlin',
      tech: 'Hilt, Jetpack Navigation, Coroutines, LiveData, Room, StateFlow, Retrofit',
      achievement:
      'Native 전환 후 앱 실행 및 콘텐츠 진입 속도 약 30% 이상 개선. '
          '전 그룹사 누적 700만 명 이상 사용자 규모에서 안정적으로 서비스 운영 중.',
    ),

    ProjectItem(
      title: 'KT Disney+ / Tving 요금제 개편 대응',
      period: '2024.01 ~ 2024.12',
      platform: 'Android App',
      summary:
      'Disney+·Tving 요금 정책 변경에 대응하여 IPTV 앱 내 요금제·부가서비스 플로우를 전면 개편한 프로젝트입니다.',
      role:
      '요금제 정책 변경에 따른 분기 로직 정리 및 UI/비즈니스 로직 구조 개선을 담당했습니다.',
      tasks: [
        '요금 인상 및 번들 정책 변경에 따른 가격 노출·옵션 선택·업셀 플로우 전면 수정',
        '복잡해진 정책 분기 로직을 상태 모델 기반 구조로 정리하여 조건 분기 단순화',
        '기존 가입자 이관 및 유지 안내 다이얼로그 설계로 예외 케이스 최소화',
        'ViewBinding·ConstraintLayout 기반 레이아웃 정리 및 회귀 테스트 시나리오 정비',
      ],
      architecture: 'MVVM + Clean Architecture (Presentation / Domain / Data Layer 분리)',
      language: 'Kotlin',
      tech: 'Hilt, Jetpack Navigation, Coroutines, LiveData, Room, StateFlow, Retrofit, DataBinding',
      achievement:
      'Disney+·Tving 요금제 개편을 일정 내 안정 반영. '
          '약 3만 명 규모의 부가서비스 사용자 대상 이관·결제 오류 없이 운영 안정화.',
    ),

    ProjectItem(
      title: 'Visual Vive - KT Altimedia Launcher / Service 앱',
      period: '2024.10 ~ 진행 중',
      platform: 'Flutter App - Android TV, Android Mobile, iOS, Web',
      summary:
      'KT Altimedia 자체 홈포탈/런처 제품으로, 콘텐츠 모듈을 조합해 UI를 구성하고 '
          'TV·모바일·웹으로 송출하는 멀티플랫폼 서비스입니다.',
      role:
      '앱 전반 아키텍처 설계 및 공통 기능 구현을 주도하며, Android TV 포커스 및 라우팅 구조 문제를 해결했습니다.',
      tasks: [
        '콘텐츠 구매·DCA 연동·EPG·My메뉴·통합 검색·VOD 상세 등 핵심 기능을 Flutter 단일 코드베이스로 설계 및 구현',
        'Android TV 리모컨 포커스 충돌 문제 해결: FocusTraversalPolicy 커스터마이징 및 Grid/Scrollable 포커스 안정화',
        'Custom RouteManager 설계 및 PlatformChannel 연동 구조 구현',
        '상태관리를 Riverpod 기반 단방향 데이터 흐름 구조로 설계하여 테스트·유지보수성 향상',
      ],
      architecture: 'Feature 기반 모듈 구조 + Riverpod 단방향 상태 관리',
      language: 'Dart',
      tech: ' Riverpod, Platform Channels, SharedPreferences, Dio',
      achievement:
      'IBC(국제방송박람회) 전시 데모 구축 및 KT 본사 제품 도입 검토 POC 참여. '
          '멀티플랫폼 동시 지원 구조를 구축하여 사내 표준 사례로 활용.',
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
