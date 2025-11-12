<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin/admin-header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>창고 목록 및 위치 조회</title>

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8284a9e56dbc80e2ab8f41c23c1bbb0a&libraries=services"></script>

  <style>
    /* ----- [기존 스타일 유지 및 수정] ----- */
    body { background-color: #f4f7f9; }
    .page-wrapper {
      width: 90%; /* 화면 너비의 90% 사용 */
      margin: 30px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }
    h1 { color: #333; border-bottom: 3px solid #5a5f78; padding-bottom: 10px; margin-bottom: 25px; font-size: 1.8em; }

    /* 지도 컨테이너 크기 */
    #map { width: 100%; height: 500px; margin-bottom: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); }

    /* ----- [버튼 디자인] ----- */
    .register-btn {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1.0em;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-bottom: 20px;
      display: inline-block;
    }
    .register-btn:hover { background-color: #0056b3; }

    /* ----- [테이블 디자인] ----- */
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      margin-bottom: 30px;
      border-radius: 8px;
      overflow: hidden;
    }
    th, td { border: none; padding: 12px 15px; text-align: center; }
    th {
      background-color: #5a5f78;
      color: white;
      font-weight: 700;
      text-transform: uppercase;
      font-size: 0.9em;
    }
    tr:nth-child(even) { background-color: #f9f9f9; }
    tr:hover { background-color: #e0f7fa; cursor: pointer; }
    a { text-decoration: none; color: #007bff; font-weight: 500; }
    a:hover { text-decoration: underline; }

    /* 마커 위 이름 표시 스타일 */
    .marker-label {
      background-color: #fff;
      border: 1px solid #000;
      padding: 2px 5px;
      font-size: 12px;
      font-weight: bold;
      color: #000;
      text-align: center;
      border-radius: 3px;
      box-shadow: 2px 2px 2px rgba(0,0,0,0.3);
      white-space: nowrap;
      cursor: pointer;
    }

    /* ----- [페이징 스타일] ----- */
    .pagination-container {
      display: flex;
      justify-content: center;
      margin-top: 20px;
      margin-bottom: 30px;
    }
    .pagination-link {
      color: #5a5f78;
      float: left;
      padding: 8px 16px;
      text-decoration: none;
      border: 1px solid #ddd;
      margin: 0 4px;
      border-radius: 4px;
      transition: background-color 0.3s;
    }
    .pagination-link.active {
      background-color: #5a5f78;
      color: white;
      border: 1px solid #5a5f78;
    }
    .pagination-link:hover:not(.active) {
      background-color: #f1f1f1;
    }

    /* 🌟 반응형 미디어 쿼리 추가 🌟 */
    @media (max-width: 768px) {
      /* 768px 이하일 때, 페이지 컨테이너 너비를 더 확대 (좌우 여백 최소화) */
      .page-wrapper {
        width: 98%;
        margin-top: 10px;
        padding: 10px;
      }

      /* 테이블이 모바일에서 가로 스크롤 되도록 설정 */
      .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch; /* iOS에서 부드러운 스크롤 */
      }

      /* 테이블 셀 패딩을 줄여서 한 화면에 더 많이 보이게 함 */
      th, td {
        padding: 8px 10px;
        font-size: 0.8em;
      }

      /* 지도 높이 조정 */
      #map {
        height: 300px;
      }

      /* 페이징 버튼 크기 조정 */
      .pagination-link {
        padding: 6px 10px;
        font-size: 0.9em;
      }

      /* 헤더 폰트 크기 조정 */
      h1 {
        font-size: 1.5em;
      }
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <h1>창고 목록 및 위치 조회</h1>

  <button onclick="location.href='${pageContext.request.contextPath}/admin/warehouses/register'" class="register-btn">
    새로운 창고 등록
  </button>

  <div id="map"></div>

  <div class="table-responsive">
    <table>
      <thead>
      <tr>
        <th>창고 ID</th>
        <th>창고 이름</th>
        <th>창고 주소</th>
        <th>창고 종류</th>
        <th>운영 현황</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="warehouse" items="${warehouseList}">
        <tr>
          <td>${warehouse.warehouseId}</td>
          <td>
            <a href="${pageContext.request.contextPath}/admin/warehouses/${warehouse.warehouseId}">
                ${warehouse.name}
            </a>
          </td>
          <td>${warehouse.address}</td>
          <td>${warehouse.warehouseType}</td>
          <td>
            <c:choose>
              <c:when test="${warehouse.warehouseStatus == 1}">운영 중</c:when>
              <c:otherwise>점검 중</c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty warehouseList}">
        <tr>
          <td colspan="5">등록된 창고가 없습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>
  </div>
  <div class="pagination-container">
    <a href="#" class="pagination-link">&laquo;</a>
    <a href="#" class="pagination-link">1</a>
    <a href="#" class="pagination-link active">2</a>
    <a href="#" class="pagination-link">3</a>
    <a href="#" class="pagination-link">4</a>
    <a href="#" class="pagination-link">&raquo;</a>
  </div>
</div>

<script type="text/javascript">
  // 서버에서 전달한 warehouseList JSON 데이터를 JS 객체로 변환
  var jsonString = '${jsWarehouseData}';
  var warehouseData = [];
  try {
    if (jsonString && jsonString.trim().length > 0) {
      // JSON 파싱 시 'jsWarehouseData' 변수에 유효한 JSON 문자열이 담겨야 합니다.
      warehouseData = JSON.parse(jsonString.replace(/&quot;/g, '"')); // 혹시 모를 HTML 엔티티 치환 처리

//오름차순 내림차순 지정 기능
      warehouseData.sort(function(a, b) {
        // ID를 숫자로 변환하여 비교합 (b - a 이면 내림차순)

        var idA = Number(a.warehouseId);
        var idB = Number(b.warehouseId);

        // 유효한 숫자가 아닐 경우를 대비하여 0을 기본값으로 사용
        return (idA || 0) - (idB || 0);
      });

      // -------------------------------------------------------------

    }
  } catch(e) {
    console.error("창고 데이터 JSON 파싱 오류:", e);
  }

  // 카카오 지도 로드 및 초기화
  kakao.maps.load(function() {
    var container = document.getElementById('map');
    if (!container) {
      console.error("지도 컨테이너(map)를 찾을 수 없습니다.");
      return;
    }

    var defaultCenter = new kakao.maps.LatLng(37.5665, 126.9780); // 서울 시청
    var options = { center: defaultCenter, level: 7 };
    var map = new kakao.maps.Map(container, options);

    var bounds = new kakao.maps.LatLngBounds();
    var hasValidCoords = false;

    if (Array.isArray(warehouseData)) {
      warehouseData.forEach(function(wh) {
        var lat = Number(wh.latitude);
        var lng = Number(wh.longitude);

        // 유효한 좌표가 아니면 건너뛰기
        if (isNaN(lat) || isNaN(lng) || lat === 0 || lng === 0) return;

        hasValidCoords = true;
        var position = new kakao.maps.LatLng(lat, lng);

        // 1. 마커 생성
        var marker = new kakao.maps.Marker({ position: position, map: map });

        // 2. CustomOverlay로 창고 이름 표시 (마커 위에 바로 보이게 함)
        // yAnchor: 1 은 마커의 바로 위에 오버레이가 위치하도록 설정합니다.
        var overlay = new kakao.maps.CustomOverlay({
          position: position,
          content: `<div class="marker-label">${wh.name}</div>`,
          map: map,
          yAnchor: 1
        });

        // 3. InfoWindow 생성
        var infowindow = new kakao.maps.InfoWindow({
          content: `<div style="padding:5px; font-weight:bold;">${wh.name}<br/>${wh.address}</div>`
        });

        // 4. 마커 및 오버레이 클릭 시 InfoWindow 열기
        kakao.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map, marker);
        });
        // 오버레이 클릭 시 마커를 기준으로 InfoWindow 열기
        kakao.maps.event.addListener(overlay, 'click', function() {
          infowindow.open(map, marker);
        });

        // 지도 범위에 좌표 추가
        bounds.extend(position);
      });
    }

    // 창고가 하나라도 유효한 좌표를 가지고 있으면 해당 범위로 지도 이동
    if (hasValidCoords) {
      map.setBounds(bounds);
    } else {
      // 유효한 좌표가 없으면 기본 위치로 설정
      map.setCenter(defaultCenter);
    }
  });
</script>
</body>
</html>
<%@ include file="../admin/admin-footer.jsp" %>