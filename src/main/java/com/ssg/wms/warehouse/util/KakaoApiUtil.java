package com.ssg.wms.warehouse.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
// ⭐ 추가된 import
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Component
public class KakaoApiUtil {

    // REST API 키 (이미지에서 확인된 최종 값)
    private final String KAKAO_REST_API_KEY = "8c029107fd9836df49ff80e83c10543d";

    private final String API_URL = "https://dapi.kakao.com/v2/local/search/address.json?query=";
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 주소를 카카오 API를 통해 위도(latitude)와 경도(longitude)로 변환합니다.
     * @param address 변환할 주소 문자열
     * @return [경도(longitude), 위도(latitude)] 배열
     * @throws Exception API 호출 실패 또는 좌표 추출 실패 시
     */
    public Double[] getCoordinates(String address) throws Exception {

        String encodedAddress; // 변수를 try 블록 밖에서 선언

        // ⭐ 1. 주소 인코딩에 try-catch 블록 추가하여 UnsupportedEncodingException 처리 ⭐
        try {
            // StandardCharsets.UTF_8 객체의 toString() 메서드를 사용하여 String 인코딩 타입을 전달
            encodedAddress = URLEncoder.encode(address, StandardCharsets.UTF_8.toString());
        } catch (UnsupportedEncodingException e) {
            // 체크 예외를 상위 Exception으로 다시 던져줍니다.
            throw new Exception("주소 인코딩 중 알 수 없는 오류가 발생했습니다.", e);
        }

        // 2. HTTP 헤더 설정 (인증 키 포함)
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + KAKAO_REST_API_KEY);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // 3. API 호출
        ResponseEntity<String> response = restTemplate.exchange(
                API_URL + encodedAddress,
                HttpMethod.GET,
                entity,
                String.class
        );

        // 4. JSON 파싱 및 좌표 추출
        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            JsonNode root = objectMapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");

            if (documents.isArray() && documents.size() > 0) {
                JsonNode firstDocument = documents.get(0);
                // 카카오 API 응답: x=경도(Longitude), y=위도(Latitude)
                double longitude = firstDocument.path("x").asDouble();
                double latitude = firstDocument.path("y").asDouble();

                // [경도(longitude), 위도(latitude)] 배열로 반환
                return new Double[]{longitude, latitude};
            }
        }

        // 좌표를 찾지 못했거나 API 응답 구조가 예상과 다를 경우
        throw new Exception("주소에 해당하는 유효한 좌표를 찾을 수 없습니다.");
    }
}