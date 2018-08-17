package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.exception.AvengerNotFoundException;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;

public class UpdateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDAO dao = AvengerDAO.getInstance();

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		context.getLogger().log("Update Avenger id: " + avenger.getId());

		Avenger avengerDelete = dao.find(avenger.getId());

		if (avengerDelete == null) {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: " + avenger.getId() + " not found");
		}
		
		Avenger updatedAvenger = dao.save(avenger);
		
		final HandlerResponse response = HandlerResponse.builder()
				.setStatusCode(200)
				.setObjectBody(updatedAvenger)
				.build(); 
		
		context.getLogger().log("End Update id: " + avenger.getId());
		
		return response;
	}
}
