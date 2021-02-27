<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>

<div class="navbar-header">
  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  </button>
  <h4><a class="navbar-brand" href="template.jsp">Cabinet de recrutement</a></h4><br/>
</div> <!-- /.navbar-header -->

<ul class="nav navbar-top-links navbar-right">

  <!-- Menu des messages -->
  
  
<% if(utilisateur == null) { %>
  <!-- Menu connexion -->
   <li class="dropdown">
	    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	      <i class="fa fa-user fa-2x"></i>
	      <i class="fa fa-caret-down fa-2x"></i>
	    </a>
	    <ul class="dropdown-menu dropdown-user">
	      
	        <li><a href="#"><i class="fa fa-user fa-fw"></i> Aucun utilisateur connect�</a></li>
	        <li class="divider"></li>
	        <li><a href="connexion.jsp"><i class="fa fa-sign-in fa-fw"></i> Login</a></li>
	        
	 	</ul>
		</li>
  <%} else if(utilisateur instanceof Entreprise){
	  	Entreprise entreprise = ((Entreprise)utilisateur);
  
  %>
  <li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		      <i class="fa fa-user fa-2x"></i>
		      <i class="fa fa-caret-down fa-2x"></i>
		    </a>
		    <ul class="dropdown-menu dropdown-user">
		      
		        <li><a href="template.jsp?action=infos_entreprise&id=<%= entreprise.getId() %>"><i class="fa fa-th"></i>  <%= entreprise.getNom() %> (Entreprise)</a></li>
		        <li class="divider"></li>
		        <li><a href="deconnexion.jsp"><i class="fa fa-sign-in fa-fw"></i>Log out</a></li>
		   	</ul>
		    </li>
  <%} else if(utilisateur instanceof Candidature){
	  	Candidature candidature = ((Candidature)utilisateur);
  %>
  
  <li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		      <i class="fa fa-user fa-2x"></i>
		      <i class="fa fa-caret-down fa-2x"></i>
		    </a>
		    <ul class="dropdown-menu dropdown-user">
		      
		        <li><a href="template.jsp?action=infos_e&id=<%= candidature.getId() %>>"><i class="fa fa-th"></i>  <%= candidature.getNom() %> <%=candidature.getPrenom() %> (Candidature)</a></li>
		        <li class="divider"></li>
		        <li><a href="deconnexion.jsp"><i class="fa fa-sign-in fa-fw"></i>Log out</a></li>
  
  <%} %>
  
  

</ul> <!-- /.navbar-top-links -->
