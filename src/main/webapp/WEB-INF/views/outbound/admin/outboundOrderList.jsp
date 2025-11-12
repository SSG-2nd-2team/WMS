<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/admin-header.jsp" %>

<!-- ✅ contextPath 변수 -->
<script>
    var contextPath = "${pageContext.request.contextPath}";
    console.log("✅ contextPath 설정됨:", contextPath);
</script>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold mb-4">출고지시서 목록</h4>

    <!-- ✅ 출고지시서 리스트 카드 -->
    <div class="card shadow-sm">
        <div class="table-responsive text-nowrap">
            <table class="table table-hover text-center align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th><input type="checkbox" id="selectAll" /></th>
                    <th>출고요청번호</th>
                    <th>출고지시서번호</th>
                    <th>브랜드</th>
                    <th>출고 요청자</th>
                    <th>출고 요청일</th>
                    <th>배송상태</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty outboundOrders}">
                        <c:forEach var="order" items="${outboundOrders}">
                            <tr>
                                <td>
                                    <input type="checkbox"
                                           name="selectedOrders"
                                           value="${order.approvedOrderID}"
                                           data-id="${order.approvedOrderID}" />
                                </td>
                                <td>${order.outboundRequestID}</td>
                                <td>${order.approvedOrderID}</td>
                                <td>${order.partnerName}</td>
                                <td>${order.driverName}</td>
                                <td>${order.outboundDate}</td>
                                <td>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${order.approvedStatus eq 'APPROVED'}">bg-label-success</c:when>
                                            <c:when test="${order.approvedStatus eq 'PENDING'}">bg-label-warning</c:when>
                                            <c:otherwise>bg-label-secondary</c:otherwise>
                                        </c:choose>">
                                            ${order.approvedStatus}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-muted py-4">등록된 출고지시서가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div class="card-footer text-end bg-light">
            <button type="button" class="btn btn-success" id="registerDispatchBtn">
                출고상태변경 / 배차등록
            </button>
        </div>
    </div>
</div>

<!-- ✅ 모달 -->
<div class="modal fade" id="dispatchModal" tabindex="-1" aria-labelledby="dispatchModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="dispatchModalLabel">배차 등록</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="dispatchModalContent">
                <div class="p-5 text-center text-muted">
                    <i class="bx bx-loader-alt bx-spin fs-1"></i>
                    <p class="mt-2">데이터를 불러오는 중입니다...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ✅ jQuery 한 번만 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ✅ JS -->
<script>
    $(function () {
        console.log("✅ 스크립트 로드 완료");

        // ✅ 전체 선택
        $("#selectAll").on("change", function () {
            $("input[name='selectedOrders']").prop("checked", this.checked);
        });

        // ✅ 배차등록 버튼 클릭 - AJAX로 모달 컨텐츠 로드
        $("#registerDispatchBtn").on("click", function () {
            console.log("=== 배차등록 버튼 클릭 ===");

            const selected = $("input[name='selectedOrders']:checked");
            console.log("✅ 선택된 체크박스 개수:", selected.length);

            if (selected.length === 0) {
                alert("출고지시서를 선택해주세요.");
                return;
            }

            const selectedId = selected.first().val();
            console.log("✅ 선택된 ID:", selectedId);

            if (!selectedId || selectedId === 'undefined' || selectedId === '') {
                console.error("❌ ID가 비어있음:", selectedId);
                alert("선택된 출고지시서 ID가 없습니다.");
                return;
            }

            // ✅ AJAX로 모달 컨텐츠 로드
            const url = contextPath + "/admin/outbound/" + selectedId + "/dispatch-form";
            console.log("✅ 모달 컨텐츠 로드 URL:", url);

            // 모달 내용을 로딩 상태로 변경
            $("#dispatchModalContent").html(`
                <div class="p-5 text-center text-muted">
                    <i class="bx bx-loader-alt bx-spin fs-1"></i>
                    <p class="mt-2">데이터를 불러오는 중입니다...</p>
                </div>
            `);

            // 모달 표시
            $("#dispatchModal").modal("show");

            // AJAX로 컨텐츠 로드
            $.ajax({
                url: url,
                type: "GET",
                success: function(response) {
                    console.log("✅ 모달 컨텐츠 로드 성공");
                    $("#dispatchModalContent").html(response);
                },
                error: function(xhr, status, error) {
                    console.error("❌ 모달 로드 실패:", error);
                    $("#dispatchModalContent").html(`
                        <div class="alert alert-danger m-3">
                            <h5>오류 발생</h5>
                            <p>데이터를 불러오는데 실패했습니다.</p>
                            <small>상태: ${xhr.status} - ${xhr.statusText}</small>
                        </div>
                    `);
                }
            });
        });
    });
</script>

<%@ include file="/WEB-INF/views/admin/admin-footer.jsp" %>