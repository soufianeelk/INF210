<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<% 

	Object utilisateur = session.getAttribute("utilisateur");

	if (utilisateur==null) {
		response.sendRedirect("index.jsp");
	
	} else {
		IServiceEntreprise serviceEntreprise=(IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
		serviceEntreprise.effaceEntreprise(((Entreprise) utilisateur).getId().intValue());	
		session.invalidate();
		%>
		
		<div class="form-group">
		  	<label class="text-success">Entreprise supprimée avec succès !</label>
		 </div>
<%}%>