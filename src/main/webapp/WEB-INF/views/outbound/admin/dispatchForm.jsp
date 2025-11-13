<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="dispatchFormContent">

  <script>
    console.log("dispatchForm loaded. contextPath =", contextPath);
  </script>

  <form id="dispatchForm">
    <input type="hidden" name="approvedOrderID" value="${dispatch.approvedOrderID}">

    <table class="table table-bordered text-center align-middle">
      <thead class="table-light">
      <tr>
        <th>출고지시서번호</th>
        <th>기사이름</th>
        <th>차량번호</th>
        <th>차량종류</th>
        <th>출고박스</th>
        <th>최대적재</th>
        <th>배차상태</th>
        <th>요청상태</th>
      </tr>
      </thead>

      <tbody>
      <tr>
        <td>${dispatch.approvedOrderID}</td>

        <!-- 기사 선택 -->
        <td>
          <select id="driverSelect" name="driverName" class="form-select" required>
            <option value="">-- 기사 선택 --</option>
          </select>
        </td>

        <!-- 차량정보 (자동입력) -->
        <td><input type="text" name="vehicleNumber" class="form-control" readonly></td>
        <td><input type="text" name="vehicleType" class="form-control" readonly></td>

        <!-- 박스 -->
        <td><input type="number" name="boxCount" class="form-control" required></td>

        <!-- 용량 -->
        <td><input type="number" name="vehicleCapacity" class="form-control" required></td>

        <!-- 배차상태 -->
        <td>
          <select name="dispatchStatus" class="form-select" required>
            <option value="대기">대기</option>
            <option value="완료">완료</option>
          </select>
        </td>

        <!-- 승인상태 -->
        <td>
          <select name="approvalStatus" class="form-select" required>
            <option value="승인">승인</option>
            <option value="반려">반려</option>
          </select>
        </td>
      </tr>
      </tbody>
    </table>

    <!-- 버튼 -->
    <div class="text-end mt-3">
      <button type="button" class="btn btn-primary" id="submitDispatchBtn">등록</button>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
    </div>
  </form>

  <script>
    $(document).ready(function () {
      console.log("🚀 dispatchForm 시작");

      var isExistingDispatch = ${dispatch.carId != null ? 'true' : 'false'};
      console.log("기존 배차 여부:", isExistingDispatch);

      // ==========================================
      // 1) 기사 목록 불러오기
      // ==========================================
      $.ajax({
        url: contextPath + "/admin/dispatches/drivers",
        type: "GET",
        dataType: "json",
        success: function (response) {
          console.log("📦 API 응답:", response);
          console.log("📦 응답 타입:", typeof response);
          console.log("📦 배열 여부:", Array.isArray(response));

          var drivers = Array.isArray(response) ? response : [response];
          console.log("📦 기사 개수:", drivers.length);

          if (!drivers || drivers.length === 0) {
            console.warn("⚠️ 기사 목록이 비어있습니다");
            alert("등록된 기사가 없습니다.");
            return;
          }

          var select = $("#driverSelect");
          select.empty();
          select.append('<option value="">-- 기사 선택 --</option>');

          // 중복 제거 (carId 기준)
          var uniqueDrivers = [];
          var seenCarIds = new Set();

          for (var i = 0; i < drivers.length; i++) {
            var d = drivers[i];
            if (d && d.carId && !seenCarIds.has(d.carId)) {
              seenCarIds.add(d.carId);
              uniqueDrivers.push(d);
            }
          }

          console.log("📦 중복 제거 후:", uniqueDrivers.length);

          // 기사 옵션 추가
          for (var j = 0; j < uniqueDrivers.length; j++) {
            var driver = uniqueDrivers[j];

            console.log("기사 " + j + ":", driver);

            var driverName = driver.driverName;
            var carId = driver.carId;
            var carType = driver.carType || '';

            console.log("→ 이름=" + driverName + ", 차량=" + carId + ", 타입=" + carType);

            if (!driverName || !carId) {
              console.warn("⚠️ 필수 정보 누락:", driver);
              continue;
            }

            var newOption = $('<option></option>');
            newOption.val(driverName);
            newOption.attr('data-car', carId);
            newOption.attr('data-type', carType);
            newOption.text(driverName + ' (' + carId + ')');

            console.log("→ 생성 HTML:", newOption.get(0).outerHTML);
            select.append(newOption);
          }

          console.log("✅ 총 옵션:", $("#driverSelect option").length - 1);

          // 초기값 설정
          if (isExistingDispatch) {
            setExistingValues();
          } else {
            setNewValues();
          }
        },
        error: function (xhr, status, error) {
          console.error("🚨 기사 목록 로드 실패");
          console.error("Status:", status);
          console.error("Error:", error);
          console.error("Response:", xhr.responseText);
          alert("기사 목록을 불러오는데 실패했습니다.");
        }
      });

      // ==========================================
      // 2) 기존 배차 값 세팅
      // ==========================================
      function setExistingValues() {
        $("input[name='vehicleNumber']").val("${dispatch.carId}");
        $("input[name='vehicleType']").val("${dispatch.carType}");
        $("input[name='boxCount']").val("${dispatch.loadedBox}");
        $("input[name='vehicleCapacity']").val("${dispatch.maximumBOX}");
        $("select[name='dispatchStatus']").val("${dispatch.dispatchStatus}");
        $("select[name='approvalStatus']").val("${dispatch.approvedStatus}");
        $("#driverSelect").val("${dispatch.driverName}");

        console.log("✅ 기존값 세팅 완료");
      }

      // ==========================================
      // 3) 신규 배차 초기값
      // ==========================================
      function setNewValues() {
        $("input[name='vehicleNumber']").val("");
        $("input[name='vehicleType']").val("");
        $("input[name='boxCount']").val(0);
        $("input[name='vehicleCapacity']").val(100);
        $("select[name='dispatchStatus']").val("대기");
        $("select[name='approvalStatus']").val("승인");

        console.log("✅ 신규값 초기화 완료");
      }

      // ==========================================
      // 4) 기사 선택 시 차량 자동입력
      // ==========================================
      $("#driverSelect").on("change", function () {
        var selectedOption = $(this).find("option:selected");
        var carId = selectedOption.attr('data-car') || "";
        var carType = selectedOption.attr('data-type') || "";

        console.log("👤 선택된 기사:", selectedOption.val());
        console.log("🚗 차량번호:", carId);
        console.log("🚙 차량종류:", carType);

        $("input[name='vehicleNumber']").val(carId);
        $("input[name='vehicleType']").val(carType);
      });

      // ==========================================
      // 5) 등록 버튼 클릭
      // ==========================================
      $("#submitDispatchBtn").on("click", function () {
        var driverName = $("#driverSelect").val();
        var vehicleNumber = $("input[name='vehicleNumber']").val();

        if (!driverName) {
          alert("기사를 선택해주세요.");
          return;
        }

        if (!vehicleNumber) {
          alert("차량번호가 없습니다.");
          return;
        }

        var data = {
          approvedOrderID: Number("${dispatch.approvedOrderID}"),
          carId: vehicleNumber,
          carType: $("input[name='vehicleType']").val(),
          driverName: driverName,
          loadedBox: Number($("input[name='boxCount']").val()),
          maximumBOX: Number($("input[name='vehicleCapacity']").val()),
          dispatchStatus: $("select[name='dispatchStatus']").val(),
          approvedStatus: $("select[name='approvalStatus']").val()
        };

        console.log("📤 전송 데이터:", data);

        $.ajax({
          url: contextPath + "/admin/outbound/" + data.approvedOrderID + "/register",
          type: "POST",
          contentType: "application/json",
          data: JSON.stringify(data),
          success: function (response) {
            console.log("✅ 등록 성공:", response);
            alert("🚚 배차 등록 완료!");
            $("#dispatchModal").modal("hide");
            location.reload();
          },
          error: function (xhr, status, error) {
            console.error("🚨 등록 실패");
            console.error("Status:", status);
            console.error("Error:", error);
            console.error("Response:", xhr.responseText);
            alert("등록 실패: " + (xhr.responseText || error));
          }
        });
      });

    });
  </script>

</div>