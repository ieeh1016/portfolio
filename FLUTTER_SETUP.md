# Flutter PATH 설정 (Windows)

`flutter` 명령을 찾을 수 없다면 아래 중 하나로 해결할 수 있습니다.

---

## 방법 1: Flutter 설치 경로를 알고 있는 경우

Flutter를 이미 설치했다면, 보통 다음 위치 중 하나에 있습니다.

- `C:\flutter`
- `C:\src\flutter`
- `D:\flutter`
- 사용자 폴더: `C:\Users\YW\flutter` 등

**PowerShell에서 현재 세션에만 PATH 추가 (테스트용):**
```powershell
$env:Path += ";C:\flutter\bin"   # 실제 설치 경로로 바꾸세요
flutter pub get
flutter run
```

**영구적으로 PATH 추가:**
1. `Win + R` → `sysdm.cpl` 입력 → Enter
2. **고급** 탭 → **환경 변수**
3. **사용자 변수**에서 **Path** 선택 → **편집**
4. **새로 만들기** → `C:\flutter\bin` (본인 Flutter 설치 경로\bin) 입력
5. 확인 후 **PowerShell/CMD를 다시 연다**
6. `flutter --version` 으로 확인

---

## 방법 2: Android Studio 터미널 사용

Android Studio에서 이 프로젝트를 연 뒤:

1. 메뉴 **View** → **Tool Windows** → **Terminal**
2. 아래쪽 터미널에서 실행:
   ```bash
   flutter pub get
   flutter run
   ```
   (Android Studio가 Flutter SDK 경로를 잡아준 경우 여기서는 동작할 수 있습니다.)

---

## 방법 3: Flutter가 설치되어 있지 않은 경우

1. https://docs.flutter.dev/get-started/install/windows 에서 Windows용 Flutter 설치 방법 확인
2. ZIP 다운로드 후 원하는 폴더에 풀기 (예: `C:\flutter`)
3. **방법 1**처럼 `C:\flutter\bin`을 사용자 PATH에 추가
4. 새 터미널에서 `flutter doctor` 실행해 의존성 확인

---

## 요약

- **가장 빠른 방법:** Android Studio에서 프로젝트 열고 **Terminal** 탭에서 `flutter pub get` → `flutter run` 실행.
- **영구 해결:** Flutter 설치 경로의 `bin` 폴더를 사용자 **Path** 환경 변수에 추가한 뒤, 터미널을 다시 연다.
