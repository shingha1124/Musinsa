# Musinsa

------

## Project Setting

### Architecture

* MVVM

### UI

* CodeBase + UIKit, SnapKit

### Third-Party

- SwiftLint

------

## 프로그래밍 요구사항

- [x] rx, react를 사용하지 않고 구현합니다.
- [x] iOS는 Swift로 작성하여야 합니다.
- [x] 네트워크, 이미지 로드에 필요한 라이브러리/프레임워크 사용해도 됩니다.
- [x] 주어진 JSON을 파싱하여 리스트를 구성합니다.

### Header

- [x] header.iconURL이 없는 경우 텍스트를 중앙 정렬하여 노출될 수 있도록 한다.

- [x] header.iconURL이 있는 경우 텍스트 + 아이콘을 중앙 정렬하여 노출될 수 있도록 한다.

- [x] header.linkURL이 있는 경우 헤더 오른쪽에 ‘전체' 텍스트 표시한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/header.png?raw=true)

### Grid Content

- [x] contents.type이 “GRID”인 경우 Contents를 3*2 형태로 노출될 수 있도록 한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/gridContent.png?raw=true)

### Scroll Content

- [x] contents.type이 “SCROLL”인 경우 Contents를 횡 스크롤 형태로 노출될 수 있도록 한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/scrollContent.gif?raw=true)

### Banner Content

- [x] contents.type이 “BANNER” 인 경우 Contents를 스와이프하여 다음 배너를 노출할 수 있도록 한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/bannerScroll.gif?raw=true)

### Style Content

- [x] contents.type이 “STYLE”인 경우 Contents를 2*2 형태로 노출될 수 있도록 한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/styleContent.png?raw=true)

### Footer

- [x] footer.type이 “REFRESH”인 경우 Contents를 랜덤하게 노출되도록 갱신한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/footer.gif?raw=true)

- [x] footer.type이 “MORE”인 경우 Contents에 다음 리스트가 한 줄 더 나오도록 추가한다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/styleFooter.gif?raw=true)

- [x] 더 이상 추가할 리스트가 없는 경우 노출을 하지 않는다.

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/footer2.png?raw=true)

- [x] contents.type이 “SCROLL”, “BANNER”인 경우 노출을 하지 않는다.

## 추가요구사항

- [x] 주어진 Json의 데이터가 많아져 노출된 화면의 리스트가 길어져도 자연스러운 스크롤이 되기를 원합니다.
- [x] "더보기" 버튼 터치 시 콘텐츠와 버튼 사이로 새로운 콘텐츠들이 추가됩니다.
- [x] "새로고침" 버튼 터치 시 노출된 콘텐츠들이 새로고침 되어 랜덤하게 변경됩니다.

## 그 외 구현사항

- [ ] 배너 자동 스크롤

  * 자동스크롤을 구현 하였지만. 자동스크롤 동작 시 CollectionView의 Scroll이 자동으로 Top로 이동하는 현상이 있음
  * 아직 해결방안을 찾지 못함

- [x] 배너 무한 스크롤

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/bannerScroll.gif?raw=true)

- [x] 섹션별 배경 적용

- [x] 더보기를 터치하여 아이템이 증가 될 경우, 증가되는 아이템의 위치로 스크롤

- [x] 각 컨텐츠 터치 시 linkUrl에 있는 링크로 이동

  ![](https://github.com/shingha1124/Musinsa/blob/main/readmeImage/openUrl.gif?raw=true)