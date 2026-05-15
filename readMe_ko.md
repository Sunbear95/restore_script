# 42 개발 환경 자동화 세팅

42 경산 Ubuntu 환경에서 사용하는 개발 환경 자동화 스크립트입니다.

이 저장소는 다음 작업들을 자동화합니다.

- goinfre 심볼릭 링크 설정
- VSCode 데이터 이동
- npm 캐시 이동
- GitHub SSH 기반 Git 설정
- lazygit 설치
- zsh alias 및 자동완성 설정
- VSCode 프로필 import

---

# 주요 기능

## goinfre 최적화

용량이 큰 디렉토리들을:

```bash
/goinfre/$USER
```

로 이동시키고 심볼릭 링크를 연결합니다.

적용 대상:

- `~/.cache`
- `~/.npm`
- `~/.vscode`
- `~/.config/Code`
- `~/.cache/Code`

42 홈 리셋 이후에도 HOME 용량을 최소화할 수 있습니다.

---

## VSCode 자동 복구

다음 항목들을 자동 복구합니다.

- VSCode 설정
- 단축키
- 확장 프로그램
- 사용자 프로필

사용 파일:

```bash
vsc_for_42.code-profile
```

---

## GitHub SSH 설정

다음 설정을 자동 적용합니다.

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

이를 통해 GitHub username/password 입력 없이 SSH 기반으로 git을 사용할 수 있습니다.

---

## lazygit 설치

sudo 없이 최신 lazygit을 설치합니다.

설치 위치:

```bash
~/.local/bin/lazygit
```

추가 설정:

```bash
alias lg="lazygit"
```

---

# 저장소 구조

```text
42-dev-setup/
├── setup_42.sh
├── README.md
├── vscode/
│   ├── vsc_for_42.code-profile
│   ├── settings.json
│   ├── keybindings.json
│   └── extensions.txt
└── scripts/
```

---

# 설치 방법

저장소 clone:

```bash
git clone git@github.com:Sunbear95/42-dev-setup.git
cd 42-dev-setup
```

실행 권한 부여:

```bash
chmod +x setup_42.sh
```

스크립트 실행:

```bash
./setup_42.sh
source ~/.zshrc
```

---

# SSH 키 설정

보안상 SSH 키는 자동 생성하지 않습니다.

직접 생성:

```bash
ssh-keygen -t ed25519 -C "jyoo@student.42gyeongsan.kr"
```

공개키 출력:

```bash
cat ~/.ssh/id_ed25519.pub
```

GitHub 등록 위치:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

테스트:

```bash
ssh -T git@github.com
```

---

# VSCode 프로필 Import

스크립트 실행 시:

```bash
vscode/vsc_for_42.code-profile
```

파일이 자동 import 됩니다.

수동 import:

```bash
code --profile "vsc_for_42" --import-profile vscode/vsc_for_42.code-profile
```

---

# 사용 목적

이 세팅은 다음 환경을 기준으로 제작되었습니다.

- 42 경산
- Ubuntu/Linux
- HOME 리셋 대응
- goinfre 용량 최적화

---

# 주의사항

다음 파일들은 절대 업로드하지 마세요.

```text
~/.ssh/id_ed25519
토큰
.env
개인 키
```

---

# 라이센스

42 프로젝트 개발 환경 자동화용 개인 설정 저장소입니다.