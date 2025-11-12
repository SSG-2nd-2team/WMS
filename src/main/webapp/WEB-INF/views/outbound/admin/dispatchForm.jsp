<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

      // ✅ 기사 목록 불러오기 (중복 호출 금지)
      $.ajax({
        url: contextPath + "/admin/dispatches/drivers",
        type: "GET",
        success: function(drivers) {
          const select = $("#driverSelect");
          select.empty().append(`<option value="">-- 기사 선택 --</option>`);

          // ✅ 드라이버 리스트 확인용 로그
          console.log("🚚 서버에서 받은 drivers:", drivers);

          // ✅ 옵션 채우기
          drivers.forEach(d => {
            const option = $('<option></option>')
                    .val(d.driverName)
                    .attr('data-car', d.carId)
                    .attr('data-type', d.carType)
                    .text(d.driverName + ' (' + d.carId + ')');
            select.append(option);
          });

          console.log("✅ 드롭다운 렌더링 완료");
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

        const data = {
          approvedOrderID: parseInt($("input[name='approvedOrderID']").val()),
          carId: parseInt(vehicleNumber.replace(/[^0-9]/g, '')) || 0,
          carType: vehicleType,
          driverName: driverName,
          loadedBox: parseInt($("input[name='boxCount']").val()) || 0,
          maximumBOX: parseInt($("input[name='vehicleCapacity']").val()) || 100,
          dispatchStatus: $("select[name='dispatchStatus']").val(),
          approvedStatus: $("select[name='approvalStatus']").val()
        };

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
            alert("배차 등록에 실패했습니다.");
          },
          complete: function() {
            $("#submitDispatchBtn").prop("disabled", false).text("등록");
          }
        });
      });
    });
  </script>

</div>
