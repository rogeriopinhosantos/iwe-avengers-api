package com.iwe.avengers;

import java.util.NoSuchElementException;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.exception.AvengerNotFoundException;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;

public class RemoveAvengerHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDAO dao = AvengerDAO.getInstance();

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {

		context.getLogger().log("Delete Avenger id: " + avenger.getId());

		try {
			Avenger avengerFind = 	dao.find(avenger.getId());
			context.getLogger().log("[#] Avenger found! Removing...");
			dao.delete(avengerFind);

			final HandlerResponse response = HandlerResponse.builder().setStatusCode(204).setObjectBody(avenger)
					.build();

			context.getLogger().log("Avenger Removed id: " + avenger.getId());

			return response;
		} catch (NoSuchElementException e) {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: " + avenger.getId() + " not found");
		}
	}
}
