package com.saki.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;

@Namespace("/")
@Action(value="productAction")
@Result(name="toProduceSelectTab",location="/pages/produce_select_tab.jsp")
public class ProductAction  extends BaseAction implements ModelDriven<TProduct>{

	private static final Logger logger = Logger.getLogger(ProductAction.class);
	
	@Override
	public TProduct getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	public ProductServiceI getProductService() {
		return productService;
	}
	@Autowired
	public void setProductService(ProductServiceI productService) {
		this.productService = productService;
	}
	private ProductServiceI productService;
	private UserProductServiceI userProductService;
	private ProductDetailServiceI productDetailService;
	
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}
	
	
	public void loadAll(){
		super.writeJson(productService.listAll());
	}
	public void loadByCompanyId(){
		super.writeJson(productService.listByCompany1(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}

	/**
	 * 产品选择页面 —— ztree 
	 */
	public void loadTreeByCompanyId()
	{
		super.writeJson(productService.listTreeByCompanyId(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}
	
	public void saveUserProduct(){
		Message j = new Message();
		try{
			//
			userProductService.delete(Integer.valueOf(getSession().getAttribute("companyId").toString()));
			userProductService.save(Integer.valueOf(getSession().getAttribute("companyId").toString()), getParameter("productlist"));
			j.setSuccess(true);
			j.setMsg("保存成功");
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	public void getUserSelectProductDetail()
	{
		super.writeJson(userProductService.getIdByCompany(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}
	
	public UserProductServiceI getUserProductService() {
		return userProductService;
	}
	@Autowired
	public void setUserProductService(UserProductServiceI userProductService) {
		this.userProductService = userProductService;
	}
	
	
	public String toProduceSelectTab()
	{
		this.getRequest().setAttribute("productList",  productService.searchProductAndChileProduct());
		this.getRequest().setAttribute("secProduct", productService.searchSecProductAndChild());
		return "toProduceSelectTab";
	}
	
	public void searchProduct()
	{
		HttpServletRequest request = this.getRequest();	
		super.writeJson(productService.searchProductById(Integer.parseInt(request.getParameter("id"))));
	}
	
	public void searchProductDetail()
	{
		HttpServletRequest request = this.getRequest();		
		super.writeJson(productDetailService.searchProductDetailById(Integer.parseInt(request.getParameter("id"))));
	}
	//删除详情
	public void deleteProductDetailById()
	{
		HttpServletRequest request = this.getRequest();
		productDetailService.deleteById(Integer.parseInt(request.getParameter("id")));
	}
	//删除类型
	public void deleteProductById()
	{
		HttpServletRequest request = this.getRequest();
		if(request.getParameter("parentId")!= null && request.getParameter("parentId") != "")
		{
			List<TProductDetail> detailList = productDetailService.loadByProductId(Integer.parseInt(request.getParameter("id")));
			for (TProductDetail tProductDetail : detailList) {
				productDetailService.deleteByProductDetail(tProductDetail);
			}			
			productService.deleteByProduct(this.productService.searchProductById(Integer.parseInt(request.getParameter("id"))));			
		}
		else
		{
			List<TProduct> productList = productService.searchChildProductType(Integer.parseInt(request.getParameter("id")));
			for (TProduct tProduct : productList) {
				List<TProductDetail> detailList = productDetailService.loadByProductId(tProduct.getId());
				for (TProductDetail tProductDetail : detailList) {
					productDetailService.deleteByProductDetail(tProductDetail);
				}
				productService.deleteByProduct(tProduct);
			}
			TProduct product = this.productService.searchProductById(Integer.parseInt(request.getParameter("id")));
			productService.deleteByProduct(product);		
		}
		
	}
	//查询一级类型
	public void searchFirstProductType()
	{
		super.writeJson(productService.searchFirstProductType());
	}
	//查询二级类型
	public void searchChildProductType()
	{
		HttpServletRequest request = this.getRequest();
		super.writeJson(productService.searchChildProductType(Integer.parseInt(request.getParameter("parentId"))));
	}
	//保存 （更新）详情
	public void saveProductDetail()
	{
		HttpServletRequest request = this.getRequest();
		String id = request.getParameter("id");
		TProductDetail detail;
		if(id==null || id=="")
		{
			 detail = new TProductDetail(null,
					   Integer.parseInt(request.getParameter("productId")), 
					   request.getParameter("subProduct"), 
					   request.getParameter("format"), 
					   request.getParameter("material"), 
					   request.getParameter("remark"));
		}
		else
		{
			 detail = new TProductDetail(Integer.parseInt(request.getParameter("id")),
					   Integer.parseInt(request.getParameter("productId")), 
					   request.getParameter("subProduct"), 
					   request.getParameter("format"), 
					   request.getParameter("material"), 
					   request.getParameter("remark"));
		}
		this.productDetailService.add(detail);
	}
	//保存（更新）类型
	public void saveProduct()
	{
		HttpServletRequest request = this.getRequest();
		String strId = request.getParameter("id");
		Integer id =null;
		
		
		String strParentId = request.getParameter("parentId");
		Integer parentId = null;
		
		if(strParentId != null && strParentId !="" )
			parentId = Integer.parseInt(strParentId);
		
		if(strId != null && strId != "")
			id = Integer.parseInt(strId);
		
		TProduct product = new TProduct(id,
				 parentId, 
				request.getParameter("product"), 
				request.getParameter("type"), 
				request.getParameter("unit"), 
				request.getParameter("base"),
				request.getParameter("remark"));

		this.productService.add(product);
	}
	//加载全部ztree(不加载选中项) 
	public void loadTree()
	{
		super.writeJson(productService.listTree());
	}
}
