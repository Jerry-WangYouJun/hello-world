package com.saki.action;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TOrder;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.OrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.SystemUtil;

@Namespace("/")
@Action(value="orderAction")
public class OrderAction extends BaseAction implements ModelDriven<TOrder>{

	private static final Logger logger = Logger.getLogger(OrderAction.class);
	private TOrder order;
	@Override
	public TOrder getModel() {
		// TODO Auto-generated method stub
		return order;
	}
	private OrderServiceI orderService;
	public OrderServiceI getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderServiceI orderService) {
		this.orderService = orderService;
	}
	public void loadAll(){
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		super.writeJson(orderService.loadAll( "startDate", "desc", page, rows));
	}
	
	public void loadByCompanyId() {
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		super.writeJson(orderService.search("companyId" , companyId , "startDate", "desc", page, rows));
	}
	public void add(){
		order.setLocked("0");
		orderService.add(order);
	}
	public void update(){
		orderService.update(order);
	}
	public void delete(){
		orderService.deleteByKey(String.valueOf(order.getId()));
	}
	
	public void updateOrderLocked(){
		String lockFlag = getParameter("locked");
		String id =getParameter("id");
		Message j = new Message();
		try {
			orderService.updateOrderLocked(lockFlag , id );
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	public void search(){
		String name = getParameter("name");
		String value = getParameter("value");
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		super.writeJson(orderService.search(name, value,sort, order, page, rows));
	}
	
	public void searchDetail() {
		String id = getParameter("id");
		if(!StringUtils.isEmpty(id)) {
			List<Map<String,Object>>  list = orderService.searchDetail(id);
			String jsonString = JSON.toJSONString(list);
			JSONArray jsonArray = JSONArray.parseArray(jsonString);
			super.writeJson(jsonArray);
		}
		
	}
	
	public void getProduct() {
		List<TProduct>  list = orderService.searchProduct();
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getProductType() {
	    String  product = getParameter("product");
	    try {
	    	if("mac".equals(SystemUtil.getSystemName())){
	    		product = new String(product.getBytes("ISO-8859-1"),"UTF-8");
	    	}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<TProduct>  list  = orderService.searchProductType(product);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getProductDetail() {
		String productId = getParameter("productId");
		List<TProductDetail> list = orderService.searchDetailByProductId(productId);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getChanges( ) {
		 String orderId = getParameter("id");
		 String insert = getParameter("inserted");
		 String update = getParameter("updated");
		 String delete = getParameter("deleted");
		 if(StringUtils.isEmpty(orderId)) {
			 String companyId = getParameter("companyId");
			 if(StringUtils.isEmpty(companyId)) {
				   companyId = String.valueOf((Integer)getSession().getAttribute("companyId"));
			 }
			 order  = new TOrder();
			 order.setOrderNo("cus_" +  DateUtil.getStringDateShort());
			 order.setCompanyId(Integer.valueOf(companyId));
			 order.setStartDate(new Date());
			 order.setStatus("1");//新订单
			 orderService.add(order);
			 insertDetail(insert);
		 }else {
			 order = (TOrder)orderService.getByKey(orderId);
			 if(StringUtils.isNotEmpty(insert)) {
				 insertDetail(insert);
			 }
			 if(StringUtils.isNotEmpty(update)) {
				   updateDetail(update);
			 }
			 if(StringUtils.isNotEmpty(delete)) {
				   deleteDetail(delete);
			 }
		 }
	     Message j = new Message();
	     j.setSuccess(true);
	     j.setMsg("添加成功");
	     super.writeJson(j);
	} 
	private void deleteDetail(String delete) {
		JSONArray jsonArr =  JSON.parseArray(delete);
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   orderService.delete(detail);
	     }
		
	}
	public void insertDetail(String insert) {
		JSONArray jsonArr =  JSON.parseArray(insert);
	     System.out.println(jsonArr);
	    // jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail.setNum(StringUtils.isEmpty(obj.getString("acount")) ? 0 : obj.getIntValue("acount"));
	    	    	   detail.setOrderId(order.getId());
	    	    	   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    	   orderService.add(detail);
	     }
	}
	
	public void updateDetail(String update) {
		JSONArray jsonArr =  JSON.parseArray(update);
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   if(detail != null) {
	    	    		   detail.setNum(StringUtils.isEmpty(obj.getString("acount")) ? 0 : obj.getIntValue("acount"));
	    	    		   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    		   if(!StringUtils.isEmpty(obj.getString("price"))){
	    	    			       detail.setPrice(obj.getDouble("price"));
	    	    		   }
	    	    		   orderService.update(detail);
	    	    	   }
	     }
	}
	public void deleteOrder(){
		Message j = new Message();
		try {
			String id = getParameter("id");
			orderService.deleteByKey(id);
			j.setSuccess(true);
			j.setMsg("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
	}
	
	public void updateStatus() {
		Message j = new Message();
		try {
			String id = getParameter("id");
			String status = getParameter("status");
			TOrder order = (TOrder)orderService.getByKey(id);
			order.setStatus(status);
			orderService.update(order);
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
}
