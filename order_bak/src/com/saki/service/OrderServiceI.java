package com.saki.service;

import java.util.List;
import java.util.Map;

import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;

public interface OrderServiceI extends BaseServiceI{

	
	List<Map<String, Object>> searchDetail(String id);

	List<TProduct> searchProduct();

	List<TProduct> searchProductType(String product);

	List<TProductDetail> searchDetailByProductId(String productId);

	TOrderDetail getByDetailId(String detailId);

	void delete(TOrderDetail detail);

	List<TOrderDetail> getOrderDetailsForSupplierOrder();
}
