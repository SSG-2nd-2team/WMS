/**
 * 공통: 이름 중복 확인
 * @설명 서버에서 { "duplicate": true/false } 형태의 JSON을 기대합니다.
 */
/**
 * warehouse.js
 * (전체 파일이 아닌, checkDuplication 함수와 연결된 로직만 표시됩니다. 기존 함수들은 이 파일에 존재한다고 가정합니다.)
 */

// ... (다른 함수 및 변수 선언) ...

// ---------------------- 1. 창고 이름 중복 확인 (오류 수정) ----------------------

function checkDuplication() {
    const name = $('#name').val().trim();
    const resultElement = $('#nameCheckResult');
    const isNameChecked = $('#isNameChecked');

    if (name === "") {
        resultElement.text("이름을 입력해주세요.").css('color', 'orange');
        isNameChecked.val("false");
        return;
    }

    // ⭐⭐ 수정 사항: Context Path를 사용하여 URL 구성 (404 오류 해결) ⭐⭐
    const url = CONTEXT_PATH + '/api/warehouses/check/name';

    $.ajax({
        url: url,
        type: 'GET',
        data: { name: name },
        dataType: 'json',

        success: function(isDuplicated) {
            if (isDuplicated === true) {
                resultElement.text("이미 사용 중인 이름입니다.").css('color', 'red');
                isNameChecked.val("false");
            } else {
                resultElement.text("사용 가능한 이름입니다.").css('color', 'green');
                isNameChecked.val("true");
            }
        },
        error: function(xhr) {
            // 404/JSON 오류 시 "서버 또는 네트워크 오류 발생" 메시지 표시
            console.error("중복 확인 AJAX 호출 실패. Status:", xhr.status, "URL:", url);
            resultElement.text("서버 또는 네트워크 오류 발생").css('color', 'red').css('font-weight', 'bold');
            isNameChecked.val("false");
        }
    });
}


/**
 * 공통: 등록폼 유효성 검사
 */
function validateForm() {
    const nameChecked = document.getElementById("isNameChecked").value === "true";

    // Spring Validation은 서버에서 처리되지만, 클라이언트에서는 이름 중복 확인 선행 검사
    if (!nameChecked) {
        alert("창고 이름 중복 확인을 해주세요.");
        return false;
    }

    // 주소, 종류, 용량 등의 유효성 검사는 서버의 @Valid 어노테이션이 담당하며,
    // 실패 시 서버에서 에러 메시지와 함께 페이지를 반환함.

    return true;
}

/**
 * 등록 페이지: 주소 검색 및 좌표 표시
 */
function searchAddress() {
    const address = document.getElementById("address").value.trim();
    if (!address) {
        alert("주소를 입력해주세요.");
        return;
    }

    const geocoder = new kakao.maps.services.Geocoder();
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            const lat = parseFloat(result[0].y);
            const lng = parseFloat(result[0].x);

            // 위도/경도 필드에 값 저장 (서버로 전송될 값)
            document.getElementById("latitude").value = lat;
            document.getElementById("longitude").value = lng;

            // 지도 표시 로직
            const mapContainer = document.getElementById("map");
            const position = new kakao.maps.LatLng(lat, lng);
            const mapOption = { center: position, level: 3 };
            const map = new kakao.maps.Map(mapContainer, mapOption);

            const marker = new kakao.maps.Marker({ position: position });
            marker.setMap(map);
        } else {
            alert("주소를 찾을 수 없습니다. 다시 입력해주세요.");
        }
    });
}

/**
 * 등록 페이지: 지도 초기화
 */
function initMapForRegister(mapId) {
    if (typeof kakao === "undefined" || typeof kakao.maps === "undefined") {
        console.error("Kakao 지도 API가 로드되지 않았습니다.");
        return;
    }

    const mapContainer = document.getElementById(mapId);
    const defaultPosition = new kakao.maps.LatLng(37.566826, 126.9786567);
    const mapOption = { center: defaultPosition, level: 7 };
    const map = new kakao.maps.Map(mapContainer, mapOption);
}

/**
 * 목록 페이지: 지도 표시
 */
function initMapForList(mapId, data) {
    if (typeof kakao === 'undefined' || typeof kakao.maps === 'undefined' || data.length === 0) {
        return;
    }

    const mapContainer = document.getElementById(mapId);
    const first = data[0] || {};
    const lat = Number(first.latitude) || 37.566826;
    const lng = Number(first.longitude) || 126.9786567;
    const center = new kakao.maps.LatLng(lat, lng);

    const map = new kakao.maps.Map(mapContainer, { center, level: 8 });

    data.forEach(w => {
        if (w.latitude && w.longitude) {
            const position = new kakao.maps.LatLng(Number(w.latitude), Number(w.longitude));
            const marker = new kakao.maps.Marker({ position, map, title: w.name });
            const infowindow = new kakao.maps.InfoWindow({
                content: `<div style="padding:5px;">${w.name}</div>`
            });
            infowindow.open(map, marker);
        }
    });
}

/**
 * 상세 페이지: 지도 표시
 */
function initMapForDetail(mapId, warehouse) {
    if (!warehouse || !warehouse.latitude || !warehouse.longitude) {
        return;
    }

    const lat = Number(warehouse.latitude);
    const lng = Number(warehouse.longitude);
    const position = new kakao.maps.LatLng(lat, lng);
    const mapContainer = document.getElementById(mapId);

    const mapOption = { center: position, level: 4 };
    const map = new kakao.maps.Map(mapContainer, mapOption);

    const marker = new kakao.maps.Marker({ position });
    marker.setMap(map);

    const infowindow = new kakao.maps.InfoWindow({
        content: `<div style="padding:5px;">${warehouse.name}</div>`
    });
    infowindow.open(map, marker);
}