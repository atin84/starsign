package com.atin84.starsign.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

/**
 * DAO 공통 인터페이스 모음
 * @author semoria
 *
 */
@SuppressWarnings("deprecation")
public class CommonDao extends SqlMapClientDaoSupport {
	/**
	 * insert
	 * @param statement
	 * @param paramMap
	 */
	public Object insert(String statement, Map<String, Object> paramMap) {
		return this.getSqlMapClientTemplate().insert(statement, paramMap);
	}
	/**
	 * update
	 * @param statement
	 * @param paramMap
	 */
	public int update(String statement, Map<String, Object> paramMap) {
		return this.getSqlMapClientTemplate().update(statement, paramMap);
	}
	/**
	 * delete
	 * @param statement
	 * @param paramMap
	 */
	public int delete(String statement, Map<String, Object> paramMap) {
		return this.getSqlMapClientTemplate().delete(statement, paramMap);
	}
	/**
	 * select to listMap
	 * @param statement
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectToListMap(String statement, Map<String, Object> paramMap) {
		return (List<Map<String, Object>>)this.getSqlMapClientTemplate().queryForList(statement, paramMap);
	}
	/**
	 * select to map
	 * @param statement
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectToMap(String statement, Map<String, Object> paramMap) {
		return (Map<String, Object>)this.getSqlMapClientTemplate().queryForObject(statement, paramMap);
	}
	/**
	 * 
	 * @param string
	 * @param param
	 * @return
	 */
	public Object selectToObj(String statement, Map<String, Object> param) {
		return this.getSqlMapClientTemplate().queryForObject(statement, param);
	}
	/**
	 * select to obj list
	 * @param statement
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<? extends Object> selectToListObj(String statement, Map<String, Object> param) {
		return this.getSqlMapClientTemplate().queryForList(statement, param);
	}
	
	public static void main(String[] args) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tset", "test");
		SqlParameterSource params = new BeanPropertySqlParameterSource(paramMap);
		System.out.println(params);
	}
}