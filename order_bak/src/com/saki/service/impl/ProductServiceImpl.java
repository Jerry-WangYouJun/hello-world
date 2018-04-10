package com.saki.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.entity.Product;
import com.saki.entity.ProductType;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;

@Service("productService")
public class ProductServiceImpl implements ProductServiceI{

	private BaseDaoI produceDao;
	public BaseDaoI getProduceDao() {
		return produceDao;
	}
	private UserProductServiceI userProductService;
	@Autowired
	public void setProduceDao(BaseDaoI produceDao) {
		this.produceDao = produceDao;
	}
	private ProductDetailServiceI productDetailService;
	
	
	public ProductDetailServiceI getProductDetailService() {
		return productDetailService;
	}
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}
	@Override
	public void add(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteByKey(String key) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getByKey(String key) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {	
		return null;
	}
	@Override
	public ArrayList<Product> listAll() {
		String hql = "from TProduct t";
		List<TProduct> ltp = produceDao.find(hql);
		ArrayList<Product> lp  = new ArrayList<Product>();		
		ArrayList<String> ls = new ArrayList<String>();
		
		for(int i=0;i<ltp.size();i++){		
			if(i > 0 && ls.indexOf(ltp.get(i).getProduct()) >= 0){
				Product product = lp.get(ls.indexOf(ltp.get(i).getProduct()));
				
				ProductType productType = new ProductType();
				ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
				productType.setBase(ltp.get(i).getBase());
				productType.setRemark(ltp.get(i).getRemark());
				productType.setType(ltp.get(i).getType());
				productType.setUnit(ltp.get(i).getUnit());
				
				ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
				
				productType.setChildren(ltd);					
				product.getChildren().add(productType);
				
				
			}else {

				Product product = new Product();
				ProductType productType = new ProductType();
				ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
				
				product.setProduct(ltp.get(i).getProduct());
				
				productType.setBase(ltp.get(i).getBase());
				productType.setRemark(ltp.get(i).getRemark());
				productType.setType(ltp.get(i).getType());
				productType.setUnit(ltp.get(i).getUnit());
				
				ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
				
				productType.setChildren(ltd);	
				
				ArrayList<ProductType> lpt = new ArrayList<ProductType>();
				lpt.add(productType);
				product.setChildren(lpt);
				lp.add(product);
				ls.add(product.getProduct());
				;
			}
		}
		return lp;
	}

	@Override
	public ArrayList<Product> listByCompany(int companyId) {
		
		String hql = "from TProduct t";
		List<TProduct> ltp = produceDao.find(hql);
		ArrayList<Product> lp  = new ArrayList<Product>();		
		ArrayList<String> ls = new ArrayList<String>();
		ArrayList<Integer> lup = userProductService.getIdByCompany(companyId);
		if(lup == null) {
			return listAll();
		}else{
			for(int i=0;i<ltp.size();i++){		
				if(i > 0 && ls.indexOf(ltp.get(i).getProduct()) >= 0){
					Product product = lp.get(ls.indexOf(ltp.get(i).getProduct()));
					
					ProductType productType = new ProductType();
					ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
					productType.setBase(ltp.get(i).getBase());
					productType.setRemark(ltp.get(i).getRemark());
					productType.setType(ltp.get(i).getType());
					productType.setUnit(ltp.get(i).getUnit());
					
					ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
					for(TProductDetail t : ltd){
						if(lup.indexOf(t.getId()) >= 0){
							t.setSelected(1);
						}else{
							t.setSelected(0);
						}
					}
					productType.setChildren(ltd);					
					product.getChildren().add(productType);
					
					
				}else {

					Product product = new Product();
					ProductType productType = new ProductType();
					ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
					
					product.setProduct(ltp.get(i).getProduct());
					
					productType.setBase(ltp.get(i).getBase());
					productType.setRemark(ltp.get(i).getRemark());
					productType.setType(ltp.get(i).getType());
					productType.setUnit(ltp.get(i).getUnit());
					
					ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
					for(TProductDetail t : ltd){
						if(lup.indexOf(t.getId()) >= 0){
							t.setSelected(1);
						}else{
							t.setSelected(0);
						}
					}
					productType.setChildren(ltd);	
					
					ArrayList<ProductType> lpt = new ArrayList<ProductType>();
					lpt.add(productType);
					product.setChildren(lpt);
					lp.add(product);
					ls.add(product.getProduct());
					;
				}
			}
			return lp;
		}
		
	}
	public UserProductServiceI getUserProductService() {
		return userProductService;
	}
	@Autowired
	public void setUserProductService(UserProductServiceI userProductService) {
		this.userProductService = userProductService;
	}
}
