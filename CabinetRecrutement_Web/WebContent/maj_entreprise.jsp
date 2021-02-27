<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>


<%

IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
Object utilisateur = session.getAttribute("utilisateur");
%>

<%
if(request.getMethod().equalsIgnoreCase("post"))
{
%>

<% 
	
	String nom = request.getParameter("nom");
	String descriptif = request.getParameter("descriptif");
	String adresse_postale = request.getParameter("adresse_postale");
	serviceEntreprise.nouvelleEntreprise(nom, descriptif, adresse_postale);
}
%>

