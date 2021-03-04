<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreDEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
 Object utilisateur = session.getAttribute("utilisateur");
 IServiceMessageCandidature servicemessagecandidature = (IServiceMessageCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCandidature");
 IServiceMessageOffreDEmploi servicemessageoffredemploi = (IServiceMessageOffreDEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreDEmploi");
 
%>

<div class="navbar-header">
  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  </button>
  <h4><a class="navbar-brand" href="template.jsp">Cabinet de recrutement</a></h4><br/>
  <% if (utilisateur instanceof Entreprise) { 
 		Entreprise e = (Entreprise) utilisateur;
  %>
  	<h4 class="navbar-brand"><small><i class="fa fa-th"></i> <%= e.getNom()%> <em>(Entreprise)</em></small></h4>
  <% } %>
  
    <% if (utilisateur instanceof Candidature) { 
 		Candidature c = (Candidature) utilisateur;
  %>
  	<h4 class="navbar-brand"><small><i class="fa fa-th"></i><%= c.getPrenom()%> <%= c.getNom()%> <em>(Candidature)</em></small></h4>
  <% } %>
</div> <!-- /.navbar-header -->

<ul class="nav navbar-top-links navbar-right">

  <!-- Menu des messages -->
  
  

  <!-- Menu connexion -->
  
  <% if(utilisateur==null) {%>
	  <li class="dropdown">
	    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	      <i class="fa fa-user fa-2x"></i>
	      <i class="fa fa-caret-down fa-2x"></i>
	    </a>
	    <ul class="dropdown-menu dropdown-user">
	      
	        <li><a href="#"><i class="fa fa-user fa-fw"></i> Aucun utilisateur connecté</a></li>
	        <li class="divider"></li>
	        <li><a href="connexion.jsp"><i class="fa fa-sign-in fa-fw"></i> Login</a></li>
	        
	 	</ul>
		</li>
   <% } else if (utilisateur instanceof Entreprise) {
	     Entreprise e = (Entreprise) utilisateur;
	   %> 
   		  <!-- Menu des messages -->
  
	    <li class="dropdown">
	      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	        <i class="fa fa-envelope fa-2x"></i>
	        <i class="fa fa-caret-down fa-2x"></i>
	      </a>
	      <ul class="dropdown-menu dropdown-messages">
	        <li>
	          <a href="#"><i class="glyphicon glyphicon-import"></i> Messages reçus<span class="pull-right text-muted"><em></em></span></a>
	        </li>
	        <li class="divider"></li>
	        <li>
	          <a href="#"><i class="glyphicon glyphicon-export"></i> Messages envoyés <span class="pull-right text-muted"><em></em></span></a>
	        </li>
	        <li class="divider"></li>
	        <li>
	          <a class="text-center" href="template.jsp?action=liste_messages">
	            <strong>Lire les messages</strong> <i class="fa fa-angle-right"></i>
	          </a>
	        </li>
	      </ul> <!-- /.dropdown-messages -->
	    </li> <!-- /.dropdown -->
	   
	   
	     <!-- Menu utilisateur -->
	   
	   	  <li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		      <i class="fa fa-user fa-2x"></i>
		      <i class="fa fa-caret-down fa-2x"></i>
		    </a>
		    <ul class="dropdown-menu dropdown-user">
		      
		        <li><a href="#"><i class="fa fa-th"></i>  <%= e.getNom() %> (Entreprise)</a></li>
		        <li class="divider"></li>
		        <li><a href="deconnexion.jsp"><i class="fa fa-sign-in fa-fw"></i>Log out</a></li>
		   	</ul>
		    </li>
		        
   <% } else if (utilisateur instanceof Candidature) {
   		Candidature c = (Candidature) utilisateur;
   %>
   
   		  <!-- Menu des messages -->
  
	    <li class="dropdown">
	      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	        <i class="fa fa-envelope fa-2x"></i>
	        <i class="fa fa-caret-down fa-2x"></i>
	      </a>
	      <ul class="dropdown-menu dropdown-messages">
	        <li>
	          <a href="#"><i class="glyphicon glyphicon-import"></i> Messages reçus<span class="pull-right text-muted"><em></em></span></a>
	        </li>
	        <li class="divider"></li>
	        <li>
	          <a href="#"><i class="glyphicon glyphicon-export"></i> Messages envoyés<span class="pull-right text-muted"><em></em></span></a>
	        </li>
	        <li class="divider"></li>
	        <li>
	          <a class="text-center" href="template.jsp?action=liste_messages">
	            <strong>Lire les messages</strong> <i class="fa fa-angle-right"></i>
	          </a>
	        </li>
	      </ul> <!-- /.dropdown-messages -->
	    </li> <!-- /.dropdown -->
	    
	       
   	     <!-- Menu utilisateur -->
   
   	   	  <li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		      <i class="fa fa-user fa-2x"></i>
		      <i class="fa fa-caret-down fa-2x"></i>
		    </a>
		    <ul class="dropdown-menu dropdown-user">
		      
		        <li><a href="#"><i class="fa fa-th"></i>  <%= c.getPrenom()%> <%=c.getNom()%> (Candidat)</a></li>
		        <li class="divider"></li>
		        <li><a href="deconnexion.jsp"><i class="fa fa-sign-in fa-fw"></i>Log out</a></li>
		    </ul>
		    </li>
   <%}%>

      
    </ul> <!-- /.dropdown-user -->
  </li> <!-- /.dropdown -->

</ul> <!-- /.navbar-top-links -->