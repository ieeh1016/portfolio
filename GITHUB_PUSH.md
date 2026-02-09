# GitHub 저장소 만들기 & 푸시

로컬 Git 초기화와 첫 커밋까지 완료된 상태입니다. 아래 순서대로 하면 **저장소 웹 URL**을 받을 수 있습니다.

---

## 1. GitHub에서 새 저장소 만들기

1. 브라우저에서 **https://github.com/new** 접속
2. **Repository name**에 예: `portfolio` 또는 `flutter-portfolio` 입력
3. **Public** 선택
4. **"Add a README file"** 체크 해제 (로컬에 이미 코드가 있으므로)
5. **Create repository** 클릭

---

## 2. 웹 URL (저장소 주소)

만들어지면 GitHub가 안내하는 주소가 곧 **웹 URL**입니다.

- **HTTPS:** `https://github.com/ieeh1016/portfolio`
- **SSH:** `git@github.com:ieeh1016/portfolio.git`

(위에서 저장소 이름을 `portfolio`로 만들었다고 가정. 다른 이름이면 `portfolio` 부분만 바꾸면 됨.)

---

## 3. 원격 연결 후 푸시

저장소를 만든 뒤, **프로젝트 폴더**에서 터미널을 열고:

```bash
git remote add origin https://github.com/ieeh1016/portfolio.git
git branch -M main
git push -u origin main
```

- 저장소 이름을 `portfolio`가 아니라 `flutter-portfolio` 등으로 만들었다면:
  ```bash
  git remote add origin https://github.com/ieeh1016/flutter-portfolio.git
  git branch -M main
  git push -u origin main
  ```

푸시가 끝나면 **웹 URL**로 접속해 코드가 올라갔는지 확인하면 됩니다.

- 예: **https://github.com/ieeh1016/portfolio**

---

## GitHub 사용자명이 다른 경우

본인 GitHub 아이디가 `ieeh1016`이 아니면:

- 위의 `ieeh1016`을 본인 아이디로 바꾸고
- `https://github.com/본인아이디/저장소이름` 이 최종 **웹 URL**입니다.
