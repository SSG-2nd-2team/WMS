<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>창고 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8284a9e56dbc80e2ab8f41c23c1bbb0a&libraries=services"></script>

    <script>
        const CONTEXT_PATH = '${pageContext.request.contextPath}';
    </script>

    <script src="${pageContext.request.contextPath}/static/warehouse/warehouse.js"></script>

    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { border-bottom: 2px solid #ccc; padding-bottom: 10px; margin-bottom: 20px; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input[type="text"], select, button { padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; }
        .input-group { margin-bottom: 15px; display: flex; align-items: center; }
        .input-group input, .input-group select { flex-grow: 1; margin-right: 10px; }

        /* 이름 중복 확인 버튼 위치 조정 */
        .name-check-group button { margin-left: 10px; background-color: #6c757d; color: white; border: none; cursor: pointer; }
        .name-check-group button:hover { background-color: #5a6268; }

        /* 구역 정보 스타일 */
        .section-container { border: 1px solid #eee; padding: 15px; margin-top: 15px; border-radius: 6px; background-color: #f9f9f9; }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .location-list { border-left: 3px solid #007bff; padding-left: 10px; margin-top: 10px; }

        /* 지도 및 위치 확인 스타일 */
        .map-container { margin-top: 20px; border: 1px solid #ddd; padding: 15px; border-radius: 4px; }
        #map { width: 100%; height: 350px; margin-top: 10px; }
        .map-controls button { background-color: #007bff; color: white; border: none; cursor: pointer; margin-right: 10px; }
        .map-controls button:hover { background-color: #0056b3; }

        /* 최종 버튼 스타일 */
        .form-buttons button { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px; }
        .form-buttons .submit { background-color: #007bff; color: white; }
        .form-buttons .cancel { background-color: #dc3545; color: white; }
    </style>
</head>
<body>

<h1>창고 등록</h1>

<c:if test="${not empty error}">
    <div style="color: red; font-weight: bold; padding: 10px; border: 1px solid red; margin-bottom: 20px;">
            ${error}
    </div>
</c:if>

<form id="warehouseRegisterForm" action="${pageContext.request.contextPath}/admin/warehouses/register" method="post" onsubmit="return validateForm();">

    <h2>창고 기본 정보</h2>

    <label for="name">창고 이름</label>
    <div class="input-group name-check-group">
        <input type="text" id="name" name="name" required onchange="document.getElementById('isNameChecked').value='false'; document.getElementById('nameCheckResult').textContent='';">
        <button type="button" onclick="checkDuplication()">중복 확인</button>
    </div>
    <div id="nameCheckResult" style="margin-bottom: 10px;"></div>
    <input type="hidden" id="isNameChecked" value="false">

    <label for="address">창고 주소</label>
    <div class="input-group">
        <input type="text" id="address" name="address" required>
    </div>

    <label for="adminId">담당자 ID</label>
    <div class="input-group">
        <input type="text" id="adminId" name="adminId" required>
    </div>

    <label for="warehouseType">창고 종류</label>
    <div class="input-group">
        <select id="warehouseType" name="warehouseType" required>
            <option value="">선택하세요</option>
            <option value="Hub">허브</option>
            <option value="Spoke">스포크</option>
        </select>
    </div>

    <label for="warehouseCapacity">총 수용 용량</label>
    <div class="input-group">
        <input type="text" id="warehouseCapacity" name="warehouseCapacity" required pattern="[0-9]*" title="숫자만 입력 가능합니다.">
    </div>

    <label for="warehouseStatus">운영 현황</label>
    <div class="input-group">
        <select id="warehouseStatus" name="warehouseStatus" required>
            <option value="">선택하세요</option>
            <option value="1">운영 중</option>
            <option value="0">점검 중</option>
        </select>
    </div>

    <input type="hidden" id="latitude" name="latitude" value="">
    <input type="hidden" id="longitude" name="longitude" value="">

    <hr>

    <h2>구역 정보 등록</h2>
    <div id="sectionsContainer">
    </div>

    <button type="button" onclick="addSection()" style="background-color: #28a745; color: white; margin-bottom: 20px;">+ 구역 추가</button>

    <hr>

    <h2>창고 위치</h2>
    <div class="map-container">
        <div class="map-controls">
            <button type="button" onclick="searchAddress()">주소로 위치 확인</button>
            <span id="coordResult" style="color: blue; font-weight: bold; margin-left: 15px;"></span>
        </div>
        <div id="map"></div>
    </div>

    <hr>

    <div class="form-buttons">
        <button type="submit" class="submit">창고 등록</button>
        <button type="button" class="cancel" onclick="location.href='${pageContext.request.contextPath}/admin/warehouses'">취소</button>
    </div>

</form>

<script>
    let sectionCount = 0; // 구역 인덱스를 관리

    // ==================== [AJAX URL 수정된] 중복 확인 함수 ====================
    function checkDuplication() {
        const name = $('#name').val().trim();
        const resultElement = $('#nameCheckResult');
        const isNameChecked = $('#isNameChecked');

        if (name === "") {
            resultElement.text("이름을 입력해주세요.").css('color', 'orange');
            isNameChecked.val("false");
            return;
        }

        // ✨ 2. Controller의 실제 매핑 경로를 CONTEXT_PATH와 결합합니다. ✨
        const url = CONTEXT_PATH + '/admin/warehouses/api/check/name';

        $.ajax({
            url: url,
            type: 'GET',
            data: { name: name },
            dataType: 'json',
            success: function(isDuplicated) {
                if (isDuplicated === true) {
                    resultElement.text("이미 사용 중인 이름입니다.").css('color', 'red');
                    isNameChecked.val("false");
                    alert("중복된 이름입니다. 다른 이름을 사용해주세요.");
                } else {
                    resultElement.text("사용 가능한 이름입니다.").css('color', 'green');
                    isNameChecked.val("true");
                    alert("사용 가능한 이름입니다.");
                }
            },
            error: function(xhr) {
                console.error("중복 확인 AJAX 호출 실패. Status:", xhr.status, "URL:", url);
                resultElement.text("서버 또는 네트워크 오류 발생").css('color', 'red').css('font-weight', 'bold');
                isNameChecked.val("false");
                alert("서버 오류로 중복 확인에 실패했습니다. (상태 코드: " + xhr.status + ")");
            }
        });
    }
    // ==================== 중복 확인 함수 끝 ====================

    // ==================== [수정된] 유효성 검사 함수 ====================
    function validateForm() {
        const nameChecked = document.getElementById("isNameChecked").value === "true";
        if (!nameChecked) {
            alert("창고 이름 중복 확인을 해주세요.");
            return false;
        }

        const lat = document.getElementById("latitude").value;
        const lng = document.getElementById("longitude").value;
        if (!lat || !lng) {
            alert("창고 주소를 입력하고 [주소로 위치 확인] 버튼을 눌러 위치를 설정해주세요.");
            return false;
        }

        // DTO 바인딩 오류 방지 및 필수 항목 확인
        const sectionCount = document.getElementById("sectionsContainer").children.length;
        if (sectionCount === 0) {
            alert("최소한 하나 이상의 구역 정보를 등록해야 합니다.");
            return false;
        }

        return true;
    }
    // ==================== 유효성 검사 함수 끝 ====================


    $(document).ready(function() {
        // 페이지 로드 시 지도 초기화 (warehouse.js의 함수 사용)
        kakao.maps.load(function() {
            if (typeof initMapForRegister === 'function') {
                initMapForRegister('map');
            } else {
                console.error("initMapForRegister 함수를 찾을 수 없습니다. warehouse.js를 확인해주세요.");
            }
        });

        // 주소 입력 필드에서 Enter 키 눌렀을 때 위치 확인 실행
        $('#address').keypress(function(e) {
            if (e.which == 13) {
                e.preventDefault();
                searchAddress();
            }
        });
    });

    // 구역 추가 함수
    function addSection() {
        // 현재 존재하는 섹션 개수를 정확한 인덱스로 사용 (0, 1, 2...)
        const index = $('#sectionsContainer > div.section-container').length;
        const displayCount = index + 1; // 화면 표시용 번호

        const container = $('#sectionsContainer');
        const newSectionHtml = `
      <div class="section-container" id="section-${displayCount}">
        <div class="section-header">
          <h4>새 구역 ${displayCount}</h4>
          <button type="button" onclick="removeSection(${displayCount})" style="background-color: #dc3545; color: white; padding: 5px 10px;">삭제</button>
        </div>

        <label for="sections_${index}_name">구역 이름 (예: 나이키 보관구역)</label>
        <input type="text" name="sections[${index}].sectionName" required>

        <label for="sections_${index}_type">구역 타입</label>
        <select name="sections[${index}].sectionType" required>
          <option value="">선택</option>
          <option value="A">A구역</option>
          <option value="B">B구역</option>
          <option value="C">C구역</option>
          <option value="D">D구역</option>
        </select>

        <label for="sections_${index}_purpose">목적</label>
        <select name="sections[${index}].sectionPurpose" required>
            <option value="">선택</option>
            <option value="보관">보관</option>
            <option value="검수">검수</option>
        </select>
        <label for="sections_${index}_area">면적</label>
        <input type="text" name="sections[${index}].allocatedArea" required pattern="[0-9]*" title="숫자만 입력 가능합니다.">

        <h5 style="margin-top: 15px;">구역 위치 정보</h5>
        <div id="locationsContainer_${index}">
          </div>
        <button type="button" onclick="addLocation(${index})" style="background-color: #17a2b8; color: white; padding: 5px 10px;">+ 위치 추가</button>
      </div>
    `;
        container.append(newSectionHtml);
    }

    // 구역 삭제 함수
    function removeSection(id) {
        $(`#section-${id}`).remove();
    }

    // 위치 추가 함수 (구역 내 로케이션)
    let locationCounter = 0; // 전체 로케이션 카운터
    function addLocation(sectionIndex) {
        locationCounter++;
        const locationIndex = $(`#locationsContainer_${sectionIndex} > div.location-list`).length;
        const displayCounter = locationCounter; // 화면 표시용 번호

        const container = $(`#locationsContainer_${sectionIndex}`);
        const locationHtml = `
      <div class="location-list" id="location-${displayCounter}">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <h6>위치 #${displayCounter}</h6>
          <button type="button" onclick="removeLocation(${displayCounter})" style="background-color: #dc3545; color: white; padding: 3px 8px; font-size: 10px;">X</button>
        </div>

        <label>위치 코드</label>
        <input type="text" name="sections[${sectionIndex}].locations[${locationIndex}].locationCode" required>

        <label>층수</label>
        <input type="text" name="sections[${sectionIndex}].locations[${locationIndex}].floorNum" required pattern="[0-9]*" title="숫자만 입력 가능합니다.">

        <label>최대 부피</label>
        <input type="text" name="sections[${sectionIndex}].locations[${locationIndex}].maxVolume" required pattern="[0-9]*" title="숫자만 입력 가능합니다.">
      </div>
    `;
        container.append(locationHtml);
    }

    // 위치 삭제 함수
    function removeLocation(id) {
        $(`#location-${id}`).remove();
    }
</script>

</body>
</html>