<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>새 창고 등록</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8284a9e56dbc80e2ab8f41c23c1bbb0a&autoload=false&libraries=services"></script>

    <style>
        #map { width: 400px; height: 300px; margin-top: 10px; border: 1px solid #ccc; }
    </style>

    <script>
        // AJAX 404 오류 해결을 위해 Context Path를 JS 변수로 선언
        const CONTEXT_PATH = "${pageContext.request.contextPath}";

        // 전역 변수로 현재 구역 인덱스를 관리 (sections[0], sections[1], ...)
        let sectionIndex = 0;

        // DOM 로드 후 최소 1개 구역 폼 추가
        document.addEventListener("DOMContentLoaded", function() {
            ensureKakaoMapsLoaded(function() {
                if(typeof initMapForRegister === 'function') {
                    initMapForRegister('map');
                }
                // 페이지 로드 시 최소 1개의 구역 폼을 추가합니다.
                addSectionForm();
            });
        });
    </script>
</head>
<body>
<h1 style="background-color: #f7d8b8; padding: 10px;">창고 등록</h1>

<form action="${pageContext.request.contextPath}/admin/warehouses/register" method="POST" onsubmit="return validateForm()">  <div style="margin-bottom: 15px;">
    <label style="background-color: #f7d8b8; padding: 5px;">창고 이름</label>
    <input type="text" id="name" name="name" required style="width: 250px;">
    <button type="button" onclick="checkDuplication()" style="background-color: green; color: white;">중복 확인</button>
    <span id="nameCheckResult" style="margin-left: 10px; font-size: 14px;"></span>
    <input type="hidden" id="isNameChecked" value="false">
</div>

    <div style="margin-bottom: 15px;">
        <label style="background-color: #f7d8b8; padding: 5px;">창고 주소</label>
        <input type="text" id="address" name="address" required style="width: 400px;">
    </div>

    <div style="margin-bottom: 15px;">
        <label style="background-color: #aaaaaa; padding: 5px;">담당자 ID</label>
        <input type="number" id="adminId" name="adminId" required style="width: 100px;">
    </div>

    <div style="margin-bottom: 15px;">
        <label style="background-color: #f7d8b8; padding: 5px;">창고 종류</label>
        <select id="warehouseType" name="warehouseType" required>
            <option value="">선택하세요</option>
            <option value="허브">허브</option>
            <option value="스포크">스포크</option>
        </select>
    </div>

    <div style="margin-bottom: 15px;">
        <label style="background-color: #f7d8b8; padding: 5px; display: inline-block;">총 수용 용량</label>
        <input type="number" id="warehouseCapacity" name="warehouseCapacity" required style="width: 150px;">
    </div>

    <div style="margin-bottom: 15px;">
        <label style="background-color: #f7d8b8; padding: 5px; display: inline-block;">운영 현황</label>
        <select id="warehouseStatus" name="warehouseStatus" required>
            <option value="">선택하세요</option>
            <option value="1">1 (운영중)</option>
            <option value="0">0 (점검중)</option>
        </select>
    </div>


    <h2 style="margin-top: 30px; border-bottom: 2px solid #ccc; padding-bottom: 5px;">구역 정보 등록</h2>

    <div id="sectionContainer">
    </div>

    <button type="button" onclick="addSectionForm()" style="background-color: darkcyan; color: white; padding: 8px 15px; margin-bottom: 20px;">
        + 구역 추가
    </button>
    <div style="margin-bottom: 15px;">
        <label style="background-color: #f7d8b8; padding: 5px;">창고 위치</label>
        <button type="button" onclick="searchAddress()" style="background-color: green; color: white;">위치 확인</button>
        <div id="map"></div>
        <input type="hidden" id="latitude" name="latitude" required>
        <input type="hidden" id="longitude" name="longitude" required>
    </div>

    <button type="submit" id="submitBtn" style="background-color: navy; color: white; padding: 10px 20px;">창고 등록</button>
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/warehouses'" style="background-color: darkred; color: white; padding: 10px 20px;">취소</button> </form>

<c:if test="${not empty error}">
    <p style="color: red; margin-top: 15px;">${error}</p>
</c:if>
<c:if test="${not empty message}">
    <p style="color: blue; margin-top: 15px;">${message}</p>
</c:if>

<script src="${pageContext.request.contextPath}/static/warehouse/warehouse.js"></script>

<script>
    // 카카오맵 로드 후 initMapForRegister 함수 호출 로직 유지
    function ensureKakaoMapsLoaded(callback) {
        if (window.kakao && kakao.maps && kakao.maps.LatLng) {
            callback();
        } else {
            kakao.maps.load(callback);
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        ensureKakaoMapsLoaded(function() {
            if(typeof initMapForRegister === 'function') {
                initMapForRegister('map');
            }
        });
    });
</script>
</body>
</html>