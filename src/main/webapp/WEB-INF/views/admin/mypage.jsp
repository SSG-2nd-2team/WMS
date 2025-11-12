<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 같은 admin 폴더 내에 있으므로 경로 없이 바로 include --%>
<%@ include file="admin-header.jsp" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">
        <span class="text-muted fw-light">설정 /</span> 내 정보
    </h4>

    <div class="row">
        <div class="col-md-12">

            <div class="card mb-4">
                <h5 class="card-header">프로필 정보</h5>
                <div class="card-body">
                    <div class="d-flex align-items-start align-items-sm-center gap-4">
                        <img src="${pageContext.request.contextPath}/resources/assets/img/avatars/1.png"
                             alt="user-avatar" class="d-block rounded" height="100" width="100" id="uploadedAvatar"/>
                        <div class="button-wrapper">
                            <label for="upload" class="btn btn-primary me-2 mb-4" tabindex="0">
                                <span class="d-none d-sm-block">사진 변경</span>
                                <i class="bx bx-upload d-block d-sm-none"></i>
                                <input type="file" id="upload" class="account-file-input" hidden
                                       accept="image/png, image/jpeg"/>
                            </label>
                            <button type="button" class="btn btn-outline-secondary account-image-reset mb-4">
                                <i class="bx bx-reset d-block d-sm-none"></i>
                                <span class="d-none d-sm-block">초기화</span>
                            </button>
                            <p class="text-muted mb-0">JPG, GIF or PNG. 최대 800K</p>
                        </div>
                    </div>
                </div>
                <hr class="my-0"/>
                <div class="card-body">
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <label for="staffName" class="form-label">이름</label>
                            <input class="form-control" type="text" id="staffName" name="staffName"
                                   value="${staff.staffName}" readonly/>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="staffLoginId" class="form-label">아이디</label>
                            <input class="form-control" type="text" name="staffLoginId" id="staffLoginId"
                                   value="${staff.staffLoginId}" readonly/>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="staffEmail" class="form-label">이메일</label>
                            <input class="form-control" type="text" id="staffEmail" name="staffEmail"
                                   value="${staff.staffEmail}" readonly/>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label class="form-label" for="staffPhone">전화번호</label>
                            <div class="input-group input-group-merge">
                                <span class="input-group-text">KR (+82)</span>
                                <input type="text" id="staffPhone" name="staffPhone" class="form-control"
                                       value="${staff.staffPhone}" readonly/>
                            </div>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="role" class="form-label">권한</label>
                            <input type="text" class="form-control" id="role" name="role" value="${staff.role}"
                                   readonly/>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="createdAt" class="form-label">가입일</label>
                            <input type="text" class="form-control" id="createdAt" name="createdAt"
                                   value="${staff.createdAt}" readonly/>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<%-- 푸터 include (필수!) --%>
<%@ include file="admin-footer.jsp" %>