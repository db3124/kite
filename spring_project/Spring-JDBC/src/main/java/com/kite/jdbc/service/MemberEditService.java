package com.kite.jdbc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kite.jdbc.dao.MemberMybatisDao;
import com.kite.jdbc.domain.Member;

@Service
public class MemberEditService {
	
	@Autowired
	MemberMybatisDao mDao;
	
	public int editMember(Member member) {
		
		return mDao.editMember(member);
	}

}
