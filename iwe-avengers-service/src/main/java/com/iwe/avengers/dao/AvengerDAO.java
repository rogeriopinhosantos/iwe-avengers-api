package com.iwe.avengers.dao;

import java.util.Optional;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.dynamodb.manager.DynamoDBManager;

public class AvengerDAO {


	private static final DynamoDBMapper mapper = DynamoDBManager.mapper();

	private static AvengerDAO instance;

	private AvengerDAO() { 
	}

	public static AvengerDAO getInstance() {
		if (instance == null) {
			instance = new AvengerDAO();
		}
		return instance;
	}

	public Avenger find(final String id) {
		final Avenger avenger = mapper.load(Avenger.class, id);
		return Optional.ofNullable(avenger).get();
	}

	public Avenger save(final Avenger avenger) {
		mapper.save(avenger);
		return avenger;
	}

	public void delete(Avenger input) {
		mapper.delete(input);
	}


}
