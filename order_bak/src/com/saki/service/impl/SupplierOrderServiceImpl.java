package com.saki.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TCompany;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TSupllierOrder;
import com.saki.model.TSupllierOrderDetail;
import com.saki.service.SupllierOrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.SystemUtil;

@Service("supllierOrderService")
public class SupplierOrderServiceImpl implements SupllierOrderServiceI{

	private BaseDaoI supplierOrderDao;
	public BaseDaoI getOrderDao() {
		return supplierOrderDao;
	}
	@Autowired
	public void setOrderDao(BaseDaoI supplierOrderDao) {
		this.supplierOrderDao = supplierOrderDao;
	}
	
	@Override
	public Grid search(Map map, String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	@Override
	public void add(Object object) {
		supplierOrderDao.save(object);
	}

	@Override
	public void update(Object object) {
		supplierOrderDao.update(object);
	}

	@Override
	public void deleteByKey(String key) {
		supplierOrderDao.delete(getByKey(key));
	}

	@SuppressWarnings("unchecked")
	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		String hql = "from TSupllierOrder t";
		if(sort!=null && order!=null){
			hql = "from TSupllierOrder t order by " + sort + " " + order;
		}
		List<TSupllierOrder> l = supplierOrderDao.find(hql);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TSupllierOrder> lp = supplierOrderDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			grid.setRows(l);
      }	
		return grid;
	}

	@Override
	public Object getByKey(String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", Integer.valueOf(key));
		TSupllierOrder t = (TSupllierOrder) supplierOrderDao.get("from TSupllierOrder t where t.id = :id", params);
		return t;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		Map<String, Object> params = new HashMap<String, Object>();		
		String hql = "from TSupllierOrder t";
		if(row!=null && text!=null){
			params.put("text", "%" + text + "%");
			hql = hql + " where t." + row + " like :text";
		}
		if(sort!=null && order!=null){
			hql = hql + " order by " + sort + " " + order;
		}	
		List<TSupllierOrder> l = supplierOrderDao.find(hql, params);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TSupllierOrder> lp = supplierOrderDao.find(hql, params, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			grid.setRows(l);
		}	
		return grid;
	}
	
	@Override
	public Grid searchBycompanyId(String row, String text, String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		Map<String, Object> params = new HashMap<String, Object>();		
		String hql = "from TSupllierOrder t  where  id  in"
				+ " (select supllierOrderId  from TSupllierOrderDetail d where d.conpanyId = " + text + " ) ";
		if(sort!=null && order!=null){
			hql = hql + " order by t." + sort + " " + order;
		}	
		List<TSupllierOrder> l = supplierOrderDao.find(hql);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TSupllierOrder> lp = supplierOrderDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			grid.setRows(l);
		}	
		return grid;
	}
	@Override
	public List<Map<String, Object>> searchDetail(String id  , String   companyId) {
		String hql = " from TProduct t , TProductDetail d, TSupllierOrder o , TSupllierOrderDetail od"
				+ " , TProduct parent ,TCompany c "
				+ " where t.id = d.productId  and o.id = od.supllierOrderId "
				+ " and od.productDetailId = d.id and c.id = od.conpanyId "
				+ " and t.parentId = parent.id  and  o.id = " + id  ;
		if(StringUtils.isNotEmpty(companyId)){
			 hql += " and od.conpanyId = " + companyId ;
		}
		List<Object[]> list = supplierOrderDao.find(hql);
		List<Map<String , Object>>  mapList = new ArrayList<Map<String , Object>>();
		for (int i = 0; i < list.size(); i++) {
			Object[] objs = list.get(i);
			//主表数据
			TProduct product = (TProduct) objs[0];
			TProductDetail productDetail = (TProductDetail) objs[1];
			TSupllierOrderDetail orderDetail = (TSupllierOrderDetail) objs[3];
			TProduct parentProduct = (TProduct) objs[4];
			Map<String , Object >  map = new HashMap<String,Object>();
			map.put("id", orderDetail.getId());
			map.put("acount", orderDetail.getNum());
			map.put("price",  orderDetail.getPrice() );
			map.put("initnum", orderDetail.getInitnum());
			
			map.put("product", parentProduct.getProduct() );
			map.put("unit", parentProduct.getUnit());
			map.put("productId", product.getId());
			map.put("type",  product.getProduct());
			map.put("sub_product", productDetail.getSubProduct());
			map.put("materail", productDetail.getMaterial());
			map.put("detailId", productDetail.getId());
			map.put("formatNum", productDetail.getFormatNum());
			map.put("format", productDetail.getFormat());
			
			if(orderDetail.getConpanyId()  != null  && orderDetail.getConpanyId()  > 0){
				map.put("companyId" ,orderDetail.getConpanyId() );
				String hqlCompany = "from TCompany  t where t.id = " + orderDetail.getConpanyId() ;
				TCompany company = (TCompany)supplierOrderDao.get(hqlCompany);
				if(company != null){
					map.put("companyName",company.getName() );
				}
			}
			mapList.add(map);
		}
		
		return mapList ;
	}
	
	public String updateDetail(String update) {
		JSONArray jsonArr =  JSON.parseArray(update);
		String msg = "";
		Map<Integer , Integer>  initMap = new HashMap<Integer , Integer>();
		Map<Integer , Integer>  updateMap = new HashMap<Integer , Integer>();
		 for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	   if(StringUtils.isEmpty(obj.getString("acount"))){
	    		     return msg += "订单数量不能为空";
	    	   }
	    	   if(StringUtils.isEmpty(obj.getString("companyId"))){
	    		     return msg += "供应商不能为空";
	    		   
	    	   }
	    	   if(StringUtils.isNotEmpty(obj.getString("initnum")) && !initMap.containsKey(obj.getIntValue("detailId"))){
	    		   initMap.put( obj.getIntValue("detailId"), obj.getIntValue("initnum"));
	    	   }
	    	   if(!updateMap.containsKey(obj.getIntValue("detailId"))){
	    		   updateMap.put(obj.getIntValue("detailId"), obj.getIntValue("acount"));
	    	   }else{
	    		   updateMap.put(obj.getIntValue("detailId"), obj.getIntValue("acount") + updateMap.get(obj.getIntValue("detailId")) ); 
	    	   }
	     }
		 for(Map.Entry<Integer, Integer> entry : initMap.entrySet()){
			  if(!entry.getValue().equals(updateMap.get(entry.getKey()))){
				  return msg += "订单数量与原始订单数量不同，请核对";  
			  }
		 }
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	   TSupllierOrderDetail detail = new TSupllierOrderDetail();
	    	   detail = (TSupllierOrderDetail)getByDetailId(obj.getString("id"));
	    	   if(detail != null) {
	    		   detail.setPrice(StringUtils.isEmpty(obj.getString("price"))?0:obj.getDouble("price"));
	    		   detail.setNum(StringUtils.isEmpty(obj.getString("acount")) ? 0 : obj.getIntValue("acount"));
	    		   detail.setConpanyId(StringUtils.isEmpty(obj.getString("companyId")) ? 0 : obj.getIntValue("companyId"));
	    		   update(detail);
	    	   }
	     }
	     
	     return msg ;
	}
	
	@Override
	public String updateSupllierPrice(String update) {
		JSONArray jsonArr =  JSON.parseArray(update);
		String msg = "";
		 for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	   if(StringUtils.isEmpty(obj.getString("price"))){
	    		     return msg += "第 "  + (i + 1) + "行单价不能为空";
	    		   
	    	   }
	     }
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	   TSupllierOrderDetail detail = new TSupllierOrderDetail();
	    	   detail = (TSupllierOrderDetail)getByDetailId(obj.getString("id"));
	    	   if(detail != null) {
	    		   detail.setPrice(StringUtils.isEmpty(obj.getString("price")) ? 0 : obj.getIntValue("price"));
	    		   update(detail);
	    	   }
	     }
	     return msg ;
	}
	
	@Override
	public List<TProduct> searchProduct() {
		  String hql = "select distinct  new TProduct(product , unit) from TProduct  " ;
		  List<TProduct> list = supplierOrderDao.find(hql);
		  return list;
		
	}
	public List<TProductDetail> searchDetailByProductId(String productId) {
		String  hql = "from TProductDetail t where t.productId = '" + productId + "'";
		List<TProductDetail> list = supplierOrderDao.find(hql);
		return list;
	}
	@Override
	public TSupllierOrderDetail getByDetailId(String id) {
		String  hql = "from TSupllierOrderDetail t where t.id = '" + id + "'";
		List<TSupllierOrderDetail> list = supplierOrderDao.find(hql);
		if(list !=null && list.size() > 0 ){
			return list.get(0);
		}
		return null;
	}
	@Override
	public void getOrderDetail() {
		
		System.out.println(new Date());
	}
	
	/**
	 * 生成供应商订单
	 */
	@Override
	public int getSupllierOrder(int confirmId) {
		if(confirmId == 0 ) {
			updateSupplierReset();
		}
	    List<TOrderDetail> orderDetailList =  getOrderDetailsForSupplierOrder(confirmId);
	    if(orderDetailList == null ||orderDetailList.size() == 0 ){
	    	 return 0;
	    }
	    //品牌ID-orderdetailList map  list中是
	    Map<String , List<TOrderDetail>> detailMapWithCompany = 
	    		new HashMap<>();
	    for(TOrderDetail orderDetail : orderDetailList) {
	  	  //对不同产品进行分类
		  	  if(detailMapWithCompany.containsKey(orderDetail.getBrand())){
		  		 detailMapWithCompany.get(orderDetail.getBrand()).add(orderDetail) ;
		  	  }else{
		  		List<TOrderDetail> tempOrderDetail = new ArrayList<>();
		  		tempOrderDetail.add(orderDetail);
		  		detailMapWithCompany.put(orderDetail.getBrand(), tempOrderDetail);
		  	  }
		}
	    Iterator<Map.Entry<String, List<TOrderDetail>>> it = detailMapWithCompany.entrySet().iterator();
	    while(it.hasNext()) {
	    	Map.Entry<String, List<TOrderDetail>>  temp = it.next();
	    		insertSupllierOrderByBrand(temp.getKey(), temp.getValue());
	    }
	    return orderDetailList.size();
	}
	
	private void insertSupllierOrderByBrand(String brand ,List<TOrderDetail> orderDetailList) {
		
		String dayOfOrderNo = DateUtil.getUserDate("yyyyMMdd");
		TSupllierOrder supOrder = new TSupllierOrder();
		int amount = 0 ;//订单总数
		List<Integer > orderList = new ArrayList<Integer >();
		Map<Integer , Integer>  tempMap = new HashMap<Integer, Integer>();
		for(TOrderDetail orderDetail : orderDetailList) {
    		//计算订单总数
	  	  if(orderDetail.getNum() != null ) {
	  		     amount += orderDetail.getNum();
	  	  }
	  	  
	  	  if(!orderList.contains(orderDetail.getOrderId())) {
	  		orderList.add(orderDetail.getOrderId());
		  	  }
	  	  //对不同产品进行分类
		  	  if(tempMap.containsKey(orderDetail.getProductDetailId())){
		  		  tempMap.put(orderDetail.getProductDetailId(), tempMap.get(orderDetail.getProductDetailId()) + orderDetail.getNum());
		  	  }else{
		  		  tempMap.put(orderDetail.getProductDetailId(), orderDetail.getNum());
		  	  }
		}
    
	    /**  插入供应商订单*/
	    supOrder.setAmount(amount);
	    supOrder.setStatus("1");//0代表新订单状态
	    supOrder.setSupplierOrderNo("GH"  + dayOfOrderNo +  getOrderCode(dayOfOrderNo) );
	    supOrder.setConfirmDate(dayOfOrderNo);
	    add(supOrder);
	    
	    /**插入供应商详情**/
	    for( Map.Entry<Integer, Integer> entry : tempMap.entrySet()) {
		  	TSupllierOrderDetail  supDetail  = new TSupllierOrderDetail();
		  	supDetail.setConpanyId(Integer.valueOf(brand));
		  	supDetail.setNum(entry.getValue());
		  	supDetail.setInitnum(entry.getValue());
		  	supDetail.setProductDetailId(entry.getKey());
		  	supDetail.setSupllierOrderId(supOrder.getId());
		  	supDetail.setStatus("1");//原始供应商订单详情，不可删除
		  	add(supDetail);	
	    }
	    
	    /**插入关系表**/
	    String ids = "";
	    
	    for(Integer orderId :  orderList){
	    		ids += orderId + "," ;
	    }
	    String updateOrderStatus ="update TOrder t set t.status = 5 , "
	    		+ " t.confirmDate = '" + dayOfOrderNo + "'  where t.id in  (" + ids + "0)";
	    supplierOrderDao.updateHql(updateOrderStatus);
	}
	
	/**
	 * 生成、重新生成供应商订单时，讲当前批次为进入采购的订单，添加入下一批次
	 * @param dayOfOrderNo
	 */
	public void updateSupplierOrderConfirmDay(Integer dayOfOrderNo , Integer nextDay) {
		//把新订单推入下一个订单日
		String resetOrderStatus = "update TOrder t set  t.confirmId = " + nextDay 
				+ " where t.status = '1'  and t.confirmId = " + dayOfOrderNo;
		supplierOrderDao.updateHql(resetOrderStatus);
	}
	
	
	private void updateSupplierReset( ) {
		String sql = "select distinct(t.confirmDate) from TSupllierOrder t where status = 1" ;
		List<String>  confirmDates = supplierOrderDao.find(sql);
		String dates = "";
		for(String date : confirmDates) {
			if(StringUtils.isNotBlank(date)) {
				dates += "'" +  date + "'," ;
			}
		}
		//删除当日新订单
		String deleteDetail = "delete from TSupllierOrderDetail t where t.supllierOrderId in ("
				+ "  select  id from TSupllierOrder where status = 1)  ";
		supplierOrderDao.updateHql(deleteDetail);
		String deleteSupllierOrder = "delete from TSupllierOrder where status = 1 ";
		supplierOrderDao.updateHql(deleteSupllierOrder);
		//更新已已付款订单的订单状态
		if(StringUtils.isNotEmpty(dates)){
			String resetOrderStatus = "update TOrder t set t.status = 3  where   1=1 " ;
			dates += " and t.confirmDate in ( " + dates.substring(0, dates.length()-1) + " )";
			supplierOrderDao.updateHql(resetOrderStatus);
		}
	}
	/**
	 * 根据采购日ID获取需要生成采购订单的客户订单信息
	 * @param confirmId
	 * @return
	 */
	private List<TOrderDetail> getOrderDetailsForSupplierOrder(int confirmId) {
		String  hql = "from TOrderDetail t  where t.orderId in ( "
				+ "select  id from TOrder o where  o.status='3' and o.percent = '100' " ;
				if(confirmId > 0) {
					hql += " and  confirmId = " + confirmId +" )";
				}else {
					hql += " )";
				}
		List<TOrderDetail> list = supplierOrderDao.find(hql);
		return list;
	}
	/**
	 * 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void splitOrder(String id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", Integer.valueOf(id));
		TSupllierOrderDetail detail = (TSupllierOrderDetail) supplierOrderDao.get("from TSupllierOrderDetail t where t.id = :id", params);
		TSupllierOrderDetail detailCopy = new TSupllierOrderDetail();
		detailCopy.setSupllierOrderId(detail.getSupllierOrderId());
		detailCopy.setProductDetailId(detail.getProductDetailId());
		detailCopy.setConpanyId(detail.getConpanyId());
		detailCopy.setStatus("2");//拆分供应商订单详情，可删除
		detailCopy.setRemark(detail.getRemark());
		add(detailCopy);
	}
	@Override
	public int deleteDetailById(String orderId, String detailId) {
		return supplierOrderDao.deleteSupDetailById(orderId , detailId );
	}
	@Override
	public List<TCompany> searchCompany(String detailId) {
		 String hql = " from TCompany t where t.roleId =  2  and t.id in "
		 		+ "(select up.companyId from TUserProduct up where up.productDetailId =  " + detailId +" )" ;
		  List<TCompany> list = supplierOrderDao.find(hql);
		  return list;
	}
	
	@Override
	public String getOrderCode(String dayOfOrderNo) {
		String hql = "select  SUBSTR(max(t.supplierOrderNo) ,LENGTH(max(t.supplierOrderNo))-2 ,3) + 1  "
				+ " from TSupllierOrder  t  where t.supplierOrderNo like '%" + dayOfOrderNo +  "%'";
		List<Integer> list =supplierOrderDao.find(hql);
		return   SystemUtil.getOrderResult(list);
	}
}
