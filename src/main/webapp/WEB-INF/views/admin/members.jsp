<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin-header.jsp" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">My Page</h4>
    <div class="card mb-4">
        <h5 class="card-header">회원 정보</h5>
        <div class="card-body">
            <div class="row gy-3">
                <!-- Default Offcanvas -->
                <div class="col-lg-3 col-md-6">
                    <table class="table table-borderless">
                        <tbody>
                        <tr>
                            <td style="white-space: nowrap;" class="align-middle"><small class="text-black fw-semibold mb-3">이름</small></td>
                            <td class="py-3">
                                <p class="mb-0">${staff.staffName}</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;" class="align-middle"><small class="text-black fw-semibold mb-3">권한</small></td>
                            <td class="py-3">
                                <p class="mb-0">${staff.role}</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;"><small class="text-black fw-semibold mb-3">ID</small></td>
                            <td class="py-3">
                                <p class="mb-0">${staff.staffLoginId}</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;"><small class="text-black fw-semibold mb-3">전화번호</small></td>
                            <td class="py-3">
                                <!-- 읽기 모드 -->
                                <p class="mb-0" id="phoneDisplay">${staff.staffPhone}</p>
                                <!-- 수정 모드 -->
                                <input type="text" class="form-control" id="phoneInput" value="${staff.staffPhone}" style="display: none;">
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;"><small class="text-black fw-semibold mb-3">Email</small></td>
                            <td class="py-3">
                                <!-- 읽기 모드 -->
                                <p style="white-space: nowrap;" class="mb-0" id="emailDisplay">${staff.staffEmail}</p>
                                <!-- 수정 모드 -->
                                <input type="email" class="form-control" id="emailInput" value="${staff.staffEmail}" style="display: none;">
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;"><small class="text-black fw-semibold mb-3">가입일</small></td>
                            <td class="py-3">
                                <p style="white-space: nowrap;" class="mb-0">${staff.createdAt}</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;"><small class="text-black fw-semibold mb-3">정보수정일</small></td>
                            <td class="py-3">
                                <p style="white-space: nowrap;" class="mb-0">${staff.updatedAt}</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
<%--                    <div>--%>
<%--                        <button type="button" class="btn rounded-pill btn-info" id="editBtn" onclick="toggleEditMode()">수정하기</button>--%>
<%--                    </div>--%>
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
