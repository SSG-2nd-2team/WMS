package com.ssg.wms.product_stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductListDTO {
    Long ps_id ;
    Long product_id;
    String product_name;
    String partner_name;
    String quantity;
    String name;
    String section_name;
}
