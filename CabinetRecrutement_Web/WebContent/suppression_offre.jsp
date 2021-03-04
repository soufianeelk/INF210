<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise
                "%>

                
<% 
Object utilisateur = session.getAttribute("utilisateur");
String id_offre=request.getParameter("id_offre");
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");

%>

 
<%  if (utilisateur==null) {
	 //response.sendRedirect("connexion.jsp");
	  %> 
	  <script>location.href="connexion.jsp";</script>
	  <%
  
} else { 
	  
	  serviceoffreemploi.removeOffreEmploi(Integer.parseInt(id_offre));
	  session.setAttribute("utilisateur", serviceEntreprise.obtenirEntreprise(((Entreprise) utilisateur).getId().intValue()));
	  %>  
	  <script>location.href="template.jsp?action=accueil";</script>
	  <%
  }%>
  