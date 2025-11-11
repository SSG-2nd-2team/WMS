<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>창고 목록 및 위치 조회</title>

  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8284a9e56dbc80e2ab8f41c23c1bbb0a&libraries=services"></script>

  <style>
    #map { width: 100%; height: 500px; }
  </style>
</head>
<body>
<h1>창고 목록 및 위치 조회</h1>

<%-- 역할 경로 설정: ADMIN/MANAGER는 해당 경로, MEMBER는 /warehouses (자신의 기본 경로) --%>
<c:set var="rolePath" value="${userRole == 'ADMIN' ? 'admin' : (userRole == 'MANAGER' ? 'manager' : 'warehouses')}" />

<c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER'}">
  <%--  등록 버튼: /admin/warehouses/register 또는 /manager/warehouses/register --%>
  <button onclick="location.href='${pageContext.request.contextPath}/${rolePath}/warehouses/register'"
          style="float: right; margin-bottom: 15px;">
    새로운 창고 등록
  </button>
</c:if>

<div id="map"></div>

<table border="1" style="width: 100%; margin-top: 20px;">
  <thead>
  <tr>
    <th>창고 ID</th>
    <th>창고 이름</th>
    <th>창고 주소</th>
    <th>창고 종류</th>
    <th>운영 현황</th>  <c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER'}">
    <th>관리</th>
  </c:if>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${tableWarehouseList}" var="warehouse">
    <tr>
      <td>${warehouse.warehouseId}</td>

        <%-- 💡 상세/목록 조회 경로: 역할과 관계없이 /warehouses/{id} (Member Controller) 사용 --%>
      <td><a href="${pageContext.request.contextPath}/warehouses/${warehouse.warehouseId}">${warehouse.name}</a></td>

      <td>${warehouse.address}</td>
      <td>${warehouse.warehouseType}</td>
      <td>${warehouse.warehouseStatus == 1 ? '운영 중' : '점검 중'}</td> <c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER'}">
      <td>
          <%-- 💡 수정/상세 버튼: /admin/warehouses/{id} 또는 /manager/warehouses/{id} --%>
        <button onclick="location.href='${pageContext.request.contextPath}/${rolePath}/warehouses/${warehouse.warehouseId}'">
          수정/상세
        </button>
      </td>
    </c:if>
    </tr>
  </c:forEach>
  <c:if test="${empty tableWarehouseList}">
    <tr>
        <%-- colspan 값 수정: 컬럼 5개 + 관리 컬럼 1개 (총 6개) --%>
      <td colspan="${userRole == 'ADMIN' || userRole == 'MANAGER' ? '6' : '5'}" style="text-align: center;">등록된 창고가 없습니다.</td>
    </tr>
  </c:if>
  </tbody>
</table>

<script>
  // Controller에서 받은 JSON 문자열을 JS 객체로 변환
  // JSON 문자열을 안전하게 출력하고 파싱합니다.
  var jsonString = '<c:out value="${jsWarehouseData}" escapeXml="false" />';
  var warehouseData = JSON.parse(jsonString || "[]");
</script>

<script src="${pageContext.request.contextPath}/static/warehouse/warehouse.js"></script>

<script>

  function ensureKakaoMapsLoaded(callback) {
    if (window.kakao && kakao.maps && kakao.maps.LatLng) {
      callback();
    } else {
      kakao.maps.load(callback); // SDK 로드가 완료되면 callback 실행
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    // DOM 로드 후, 지도가 준비되면 initMapForList 호출
    ensureKakaoMapsLoaded(function() {
      // initMapForList 함수는 warehouse.js에 정의되어 있어야 합니다.
      if (typeof initMapForList === 'function') {
        initMapForList('map', warehouseData);
      } else {
        console.error("initMapForList 함수를 찾을 수 없습니다. warehouse.js 파일 확인 필요.");
      }
    });
  });
</script>
</body>
</html>