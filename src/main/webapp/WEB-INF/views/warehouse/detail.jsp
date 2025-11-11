<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>창고 상세 정보: ${detail.name}</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8284a9e56dbc80e2ab8f41c23c1bbb0a"></script>
  <style>
    #map { width: 400px; height: 300px; margin-top: 10px; border: 1px solid #ccc; }
    /* 모달 스타일 유지 */
    .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
    .modal-content { background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 300px; text-align: center; border-radius: 8px; }

    /* 테이블 스타일 */
    table.info-table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
    table.info-table th, table.info-table td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    table.info-table th { background-color: #f2f2f2; width: 30%; }

    .section-header {
      background-color: #f0f0f0;
      padding: 8px;
      margin-top: 20px;
      font-size: 1.1em;
      font-weight: bold;
      border-bottom: 1px solid #ccc;
    }
  </style>
</head>
<body>
<h1>창고 상세 페이지</h1>

<div style="float: left; width: 55%; padding-right: 20px;">

  <h2>창고 기본 정보</h2>
  <table class="info-table">
    <tr><th>창고 ID</th><td>${detail.warehouseId}</td></tr>
    <tr><th>창고 이름</th><td>${detail.name}</td></tr>
    <tr><th>담당자 ID</th><td>${detail.adminId}</td></tr>
    <tr><th>창고 주소</th><td>${detail.address}</td></tr>
    <tr><th>창고 종류</th><td>${detail.warehouseType}</td></tr>
    <tr><th>수용 용량</th><td>${detail.warehouseCapacity}</td></tr>
    <tr><th>운영 현황</th><td>${detail.warehouseStatus == 1 ? '운영 중' : '점검 중'}</td></tr>
    <tr><th>등록 일자</th><td>${detail.registrationDate}</td></tr>
    <tr><th>최종 수정</th><td>${detail.latestUpdateDate}</td></tr>
  </table>

  <h2>구역 정보</h2>

  <%-- A구역 데이터 추출 --%>
  <c:set var="aSection" value="${null}"/>
  <c:forEach items="${detail.sections}" var="section">
    <c:if test="${section.sectionName == 'A구역'}">
      <c:set var="aSection" value="${section}"/>
    </c:if>
  </c:forEach>

  <c:choose>
    <c:when test="${not empty aSection}">
      <div class="section-header">A구역 (${aSection.sectionType})</div>
      <table class="info-table">
        <tr><th>목적</th><td>${aSection.sectionPurpose}</td></tr>
        <tr><th>면적</th><td>${aSection.allocatedArea}</td></tr>
      </table>

      <h4>A구역 위치 정보</h4>
      <ul style="list-style-type: none; padding-left: 0;">
        <c:forEach items="${aSection.locations}" var="location">
          <li>[${location.locationCode}] 층수: ${location.floorNum}, 최대 부피: ${location.maxVolume}</li>
        </c:forEach>
        <c:if test="${empty aSection.locations}"><li>등록된 위치가 없습니다.</li></c:if>
      </ul>
    </c:when>
    <c:otherwise>
      <div class="section-header">A구역 (정보 없음)</div>
      <p>등록된 A구역 정보가 없습니다.</p>
    </c:otherwise>
  </c:choose>

  <%-- B구역 데이터 추출 --%>
  <c:set var="bSection" value="${null}"/>
  <c:forEach items="${detail.sections}" var="section">
    <c:if test="${section.sectionName == 'B구역'}">
      <c:set var="bSection" value="${section}"/>
    </c:if>
  </c:forEach>

  <c:choose>
    <c:when test="${not empty bSection}">
      <div class="section-header">B구역 (${bSection.sectionType})</div>
      <table class="info-table">
        <tr><th>목적</th><td>${bSection.sectionPurpose}</td></tr>
        <tr><th>면적</th><td>${bSection.allocatedArea}</td></tr>
      </table>

      <h4>B구역 위치 정보</h4>
      <ul style="list-style-type: none; padding-left: 0;">
        <c:forEach items="${bSection.locations}" var="location">
          <li>[${location.locationCode}] 층수: ${location.floorNum}, 최대 부피: ${location.maxVolume}</li>
        </c:forEach>
        <c:if test="${empty bSection.locations}"><li>등록된 위치가 없습니다.</li></c:if>
      </ul>
    </c:when>
    <c:otherwise>
      <div class="section-header">B구역 (정보 없음)</div>
      <p>등록된 B구역 정보가 없습니다.</p>
    </c:otherwise>
  </c:choose>
</div>

<div style="float: right; width: 40%;">
  <h2>창고 위치</h2>
  <div id="map" style="width: 100%; height: 350px;"></div>
</div>
<div style="clear: both;"></div>

<hr>

<c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER'}">
  <div style="margin-top: 20px;">
      <%--  수정 버튼: userRole을 사용하여 경로 동적 생성  --%>
    <button onclick="location.href='${pageContext.request.contextPath}/${userRole == 'ADMIN' ? 'admin' : 'manager'}/warehouses/${detail.warehouseId}/modify'"
            style="background-color: navy; color: white; padding: 10px 20px;">수정하기</button>

    <button onclick="showDeleteModal()"
            style="background-color: darkred; color: white; padding: 10px 20px;">삭제</button>
  </div>
</c:if>

<%--삭제 모달 기능 --%>
<div id="deleteModal" class="modal">
  <div class="modal-content">
    <h2>정말 삭제하시겠습니까?</h2>
    <p>창고 ${detail.name} (ID: ${detail.warehouseId}) 정보를 복구할 수 없습니다.</p>

    <%-- Action 경로 수정Role을 사용하여 경로 동적 생성  --%>
    <form action="${pageContext.request.contextPath}/${userRole == 'ADMIN' ? 'admin' : 'manager'}/warehouses/${detail.warehouseId}/delete" method="POST" style="display: inline;">
      <button type="submit" style="background-color: navy; color: white; padding: 10px 20px;">예</button>
    </form>

    <button onclick="hideDeleteModal()" style="background-color: darkred; color: white; padding: 10px 20px;">아니요</button>
  </div>
</div>

<button onclick="location.href='${pageContext.request.contextPath}/warehouses'" style="margin-top: 10px;">목록으로</button>

<script src="${pageContext.request.contextPath}/static/warehouse/warehouse.js"></script>
<script>
  // 마커 표시를 위한 데이터
  const detailData = {
    latitude: ${detail.latitude},
    longitude: ${detail.longitude},
    name: '${detail.name}'
  };

  // 지도 초기화
  kakao.maps.load(function() {
    if (typeof initMapForDetail === 'function') {
      initMapForDetail('map', detailData);
    } else {
      console.error("initMapForDetail 함수를 찾을 수 없습니다. warehouse.js를 확인해주세요.");
    }
  });

  // 모달 제어 함수 (유지)
  function showDeleteModal() {
    document.getElementById('deleteModal').style.display = 'block';
  }
  function hideDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
  }
</script>
</body>
</html>