package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;

public class CreateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDAO dao = AvengerDAO.getInstance();
	
	@Override
	public HandlerResponse handleRequest(final Avenger newAvenger, final Context context) {
		context.getLogger().log("[#] - Iniate registry");
		
		final Avenger avenger = dao.save(newAvenger);
		
		final HandlerResponse response = HandlerResponse.builder()
				.setStatusCode(200)
				.setObjectBody(avenger)
				.build(); 
		
		context.getLogger().log("[#] - Avenger registered successfully");
		
		return response;

	}
}
