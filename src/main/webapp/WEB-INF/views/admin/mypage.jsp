<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="admin-header.jsp" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">My Page</h4>
    <div class="card mb-4">
        <h5 class="card-header">회원 정보</h5>
        <div class="card-body">
            <div class="row gy-3">
                <!-- Default Offcanvas -->
                <div class="col-lg-3 col-md-6">
                    <div>
                        <small class="text-black fw-semibold mb-3">이름</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">권한</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">ID</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">전화번호</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">Email</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">가입일</small>

                    </div>
                    <div>
                        <small class="text-black fw-semibold mb-3">정보수정일</small>

                    </div>
<%--                    <div>--%>
<%--                        <small class="text-black fw-semibold mb-3">거래처명</small>--%>
<%--                    </div>--%>
                    <div>
                        <button type="button" class="btn rounded-pill btn-info">수정하기</button>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <div class="card">
        <h5 class="card-header">Backdrop</h5>
        <div class="card-body">

        </div>
    </div>
</div>
<!-- / Content -->
<%@ include file="admin-footer.jsp" %>
