<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ✅ Fragment 시작 -->
<div id="dispatchFormContent">
  <script>
    var contextPath = "${pageContext.request.contextPath}";
    console.log("✅ dispatchForm contextPath:", contextPath);
  </script>

  <form id="dispatchForm">
    <input type="hidden" name="approvedOrderID" value="${dispatch.approvedOrderID}">

    <table class="table table-bordered text-center align-middle">
      <thead class="table-light">
      <tr>
        <th>출고지시서번호</th>
        <th>차량번호</th>
        <th>차량종류</th>
        <th>기사이름</th>
        <th>출고박스</th>
        <th>최대적재</th>
        <th>배차상태</th>
        <th>요청상태</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>${dispatch.approvedOrderID}</td>
        <td><input type="text" name="vehicleNumber" class="form-control" required></td>
        <td><input type="text" name="vehicleType" class="form-control" required></td>
        <td>
          <select id="driverSelect" name="driverName" class="form-select" required>
            <option value="">-- 기사 선택 --</option>
          </select>
        </td>
        <td><input type="number" name="boxCount" class="form-control" value="0" required></td>
        <td><input type="number" name="vehicleCapacity" class="form-control" value="100" required></td>
        <td>
          <select name="dispatchStatus" class="form-select" required>
            <option value="대기">대기</option>
            <option value="완료">완료</option>
          </select>
        </td>
        <td>
          <select name="approvalStatus" class="form-select" required>
            <option value="승인">승인</option>
            <option value="반려">반려</option>
          </select>
        </td>
      </tr>
      </tbody>
    </table>

    <div class="text-end mt-3">
      <button type="button" class="btn btn-primary" id="submitDispatchBtn">등록</button>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
    </div>
  </form>

  <script>
    $(document).ready(function() {
      console.log("✅ dispatchForm 스크립트 로드됨");

      // ✅ 로컬스토리지에서 이전 입력값 복원
      function restoreFormData() {
        const savedData = localStorage.getItem('dispatchFormData');
        if (savedData) {
          try {
            const data = JSON.parse(savedData);
            console.log("✅ 저장된 데이터 복원:", data);

            if (data.driverName) $("#driverSelect").val(data.driverName);
            if (data.vehicleNumber) $("input[name='vehicleNumber']").val(data.vehicleNumber);
            if (data.vehicleType) $("input[name='vehicleType']").val(data.vehicleType);
            if (data.boxCount !== undefined) $("input[name='boxCount']").val(data.boxCount);
            if (data.vehicleCapacity !== undefined) $("input[name='vehicleCapacity']").val(data.vehicleCapacity);
            if (data.dispatchStatus) $("select[name='dispatchStatus']").val(data.dispatchStatus);
            if (data.approvalStatus) $("select[name='approvalStatus']").val(data.approvalStatus);
          } catch (e) {
            console.error("❌ 데이터 복원 실패:", e);
          }
        }
      }

      // ✅ 승인 상태 체크 (중복 방지)
      function checkApprovalStatus() {
        const instructionId = $("input[name='approvedOrderID']").val();

        return $.ajax({
          url: contextPath + "/admin/outbound/" + instructionId + "/status",
          type: "GET",
          dataType: "json"
        });
      }

      // ✅ 기사 목록 불러오기
      $.ajax({
        url: contextPath + "/admin/dispatches/drivers",
        type: "GET",
        success: function(drivers) {
          const select = $("#driverSelect");
          select.empty().append(`<option value="">-- 기사 선택 --</option>`);

          console.log("🚚 서버에서 받은 drivers:", drivers);

          drivers.forEach(d => {
            const option = $('<option></option>')
                    .val(d.driverName)
                    .attr('data-car', d.carId)
                    .attr('data-type', d.carType)
                    .text(d.driverName + ' (' + d.carId + ')');
            select.append(option);
          });

          console.log("✅ 드롭다운 렌더링 완료");

          // ✅ 드롭다운 로드 후 저장된 데이터 복원
          restoreFormData();
        },
        error: function(xhr) {
          console.error("❌ 기사 목록 로드 실패:", xhr);
        }
      });

      // ✅ 기사 선택 시 차량정보 자동 채움
      $("#driverSelect").on("change", function() {
        const selected = $(this).find("option:selected");
        const carNumber = selected.data("car") || "";
        const carType = selected.data("type") || "";

        $("input[name='vehicleNumber']").val(carNumber);
        $("input[name='vehicleType']").val(carType);
      });

      // ✅ 등록 버튼 이벤트
      $("#submitDispatchBtn").off("click").on("click", function(e) {
        e.preventDefault();
        console.log("=== 등록 버튼 클릭 ===");

        const vehicleNumber = $("input[name='vehicleNumber']").val().trim();
        const vehicleType = $("input[name='vehicleType']").val().trim();
        const driverName = $("#driverSelect").val();

        if (!vehicleNumber || !vehicleType || !driverName) {
          alert("필수 항목을 모두 입력해주세요.");
          return;
        }

        // ✅ 먼저 승인 상태 확인
        checkApprovalStatus()
                .done(function(response) {
                  console.log("✅ 승인 상태 확인:", response);

                  if (response.approvedStatus === "승인") {
                    alert("⚠️ 이미 승인된 건입니다.\n중복 등록할 수 없습니다.");
                    return;
                  }

                  // ✅ 승인되지 않은 경우 등록 진행
                  proceedWithRegistration();
                })
                .fail(function(xhr) {
                  console.error("❌ 상태 확인 실패:", xhr);

                  // 상태 확인 실패 시에도 등록 진행 (백엔드에서 한 번 더 체크)
                  if (confirm("승인 상태를 확인할 수 없습니다.\n계속 진행하시겠습니까?")) {
                    proceedWithRegistration();
                  }
                });
      });

      // ✅ 실제 등록 처리 함수
      function proceedWithRegistration() {
        const data = {
          approvedOrderID: parseInt($("input[name='approvedOrderID']").val()),
          carId: parseInt($("input[name='vehicleNumber']").val().replace(/[^0-9]/g, '')) || 0,
          carType: $("input[name='vehicleType']").val().trim(),
          driverName: $("#driverSelect").val(),
          loadedBox: parseInt($("input[name='boxCount']").val()) || 0,
          maximumBOX: parseInt($("input[name='vehicleCapacity']").val()) || 100,
          dispatchStatus: $("select[name='dispatchStatus']").val(),
          approvedStatus: $("select[name='approvalStatus']").val()
        };

        // ✅ 로컬스토리지에 데이터 저장 (승인 정보 제외)
        const formDataToSave = {
          driverName: data.driverName,
          vehicleNumber: $("input[name='vehicleNumber']").val(),
          vehicleType: data.carType,
          boxCount: data.loadedBox,
          vehicleCapacity: data.maximumBOX,
          dispatchStatus: data.dispatchStatus,
          approvalStatus: data.approvedStatus
        };
        localStorage.setItem('dispatchFormData', JSON.stringify(formDataToSave));

        const url = contextPath + "/admin/outbound/" + data.approvedOrderID + "/register";

        console.log("🚀 전송 URL:", url);
        console.log("🚀 데이터:", JSON.stringify(data, null, 2));

        $.ajax({
          url: url,
          type: "POST",
          contentType: "application/json; charset=utf-8",
          dataType: "text",
          data: JSON.stringify(data),
          beforeSend: function() {
            $("#submitDispatchBtn").prop("disabled", true).text("처리중...");
          },
          success: function(response) {
            alert("✅ 배차 등록이 완료되었습니다!");
            $("#dispatchModal").modal("hide");
            setTimeout(() => location.reload(), 500);
          },
          error: function(xhr) {
            console.error("❌ 배차 등록 실패:", xhr);

            // ✅ 중복 승인 에러 체크
            if (xhr.responseJSON && xhr.responseJSON.message) {
              alert(xhr.responseJSON.message);
            } else if (xhr.responseText && xhr.responseText.includes("이미 승인")) {
              alert("⚠️ 이미 승인된 건입니다.");
            } else {
              alert("배차 등록에 실패했습니다.");
            }
          },
          complete: function() {
            $("#submitDispatchBtn").prop("disabled", false).text("등록");
          }
        });
      }
    });
  </script>

</div>