<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
				eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
			    eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi,
                java.util.Calendar
                "

%>

<%

	IServiceCandidature servicecandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
	IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
		%>

<%  

	response.sendRedirect("template.jsp"); 
	Object utilisateur = session.getAttribute("utilisateur"); 
%>
 <%  if (utilisateur==null) {
	 //response.sendRedirect("connexion.jsp");
	  %> 
	  <script>location.href="connexion.jsp";</script>
	  <%
  }
  else { 
	  
	  if("GET".equals(request.getMethod())) {
	  
			  Entreprise e = (Entreprise) utilisateur;
			  String idCandidature = request.getParameter("id_candidature");
			  String idOffre = request.getParameter("id_offre");
		  	  Candidature c = servicecandidature.obtenirCandidature(Integer.parseInt(idCandidature));
		  	  OffreEmploi offre = serviceoffreemploi.getOffreEmploi(Integer.parseInt(idOffre));
		  %>
		
		<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		      <div class="panel-heading">
		        <h3><i class="fa fa-envelope"></i> Message</h3>
		      </div> <!-- /.panel-heading -->
		      <div class="panel-body">
		
		        
		                            
		            <div class="col-lg-offset-2 col-lg-8
		                        col-xs-12">
		
		              <div class="alert alert-info">
		                <table border="0" align="center">
		                  <tr>
		                    <td width=200 align="center">
		                      <i class="fa fa-th fa-2x"></i><br/>
		                      <%=e.getNom()%><br/>
		                      <em><%=offre.getTitre()%></em>
		                    </td>
		                    <td width=50 align="center">
		                      <i class="fa fa-arrow-right fa-2x"></i>
		                    </td>
		                    <td width=200 align="center">
		                      <i class="fa fa-user fa-2x"></i><br/>
		                     <%=c.getPrenom()%> <%=c.getNom()%>
		                     <br/>
		                      
		                    </td>
		                  </tr>
		                </table>
		              </div>
		              
		              <form role="form" action="template.jsp" method="post">
		                <input type="hidden" name="action" value="nouveau_message_offre_emploi" />
		                <input type="hidden" name="action2" value="enregistrer" />
		                <input type="hidden" name="id_offre" value="<%=idOffre%>" />
		                <input type="hidden" name="id_candidature" value="<%=c.getId().intValue()%>" />
		                <div class="form-group">
		                  <textarea class="form-control" placeholder="Contenu du message" rows="5" name="corps_message"></textarea>
		                </div>
		                <div class="text-center">
		                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
		                  <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
		                </div>
		              </form>
		            </div>
		            
		
		      </div> <!-- /.panel-body -->
		    </div> <!-- /.panel -->
		  </div> <!-- /.col-lg-12 -->
		</div> <!-- /.row -->
		<%}else{%>
		
			<% String idCandidature = request.getParameter("id_candidature");
			  String idOffre = request.getParameter("id_offre");
		  	  Candidature c = servicecandidature.obtenirCandidature(Integer.parseInt(idCandidature));
		  	  OffreEmploi offre = serviceoffreemploi.getOffreEmploi(Integer.parseInt(idOffre)); 
		  	  String message = request.getParameter("corps_message");
		  	  IServiceMessageOffreEmploi serviceMessageOffreEmploi = (IServiceMessageOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreEmploi");
		
		  	  MessageOffreDemploi messageOffreEmploi = serviceMessageOffreEmploi.newMessageOffreEmploi(message, Calendar.getInstance().getTime(), c.getId().intValue(), offre.getId().intValue());
		  	  
		  	  
		  	  %>
			
			<div class="row">
			  <div class="col-lg-12">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h3><i class="fa fa-envelope"></i> Message</h3>
			      </div> <!-- /.panel-heading -->
			      <div class="panel-body">
			
			        
			              <div class="col-lg-offset-2 col-lg-8
			                          col-xs-12">
			                <div class="panel panel-success">
			                  <div class="panel-heading">
			                    Nouveau message envoyé
			                  </div>
			                  <div class="panel-body">
			                    <small>
			                      <table class="table">
			                        <tbody>
			                          <tr class="success">
			                            <td><strong>Identifiant</strong></td>
			                            <td><%=messageOffreEmploi.getId().intValue()%></td>
			                          </tr>
			                          <tr class="warning">
			                            <td><strong>Offre emploi concernée</strong></td>
			                            <td><%=offre.getTitre()%> (<%=offre.getEntrepriseBean().getNom()%>)</td>
			                          </tr>
			                          <tr class="warning">
			                            <td><strong>Candidature</strong></td>
			                            <td><%=c.getPrenom()%> <%=c.getNom()%> (CAND_<%=c.getId().intValue()%>)</td>
			                          </tr>
			                          <tr class="warning">
			                            <td><strong>Date d'envoi</strong></td>
			                            <td><%=Calendar.getInstance().getTime().toString()%></td>
			                          </tr>
			                          <tr class="warning">
			                            <td><strong>Contenu du message</strong></td>
			                            <td><%=messageOffreEmploi.getCorpsmessage()%></td>
			                          </tr>
			                        </tbody>
			                      </table>
			                    </small>
			                  </div>
			                </div>
			              </div>
			            
			
			      </div> <!-- /.panel-body -->
			    </div> <!-- /.panel -->
			  </div> <!-- /.col-lg-12 -->
			</div> <!-- /.row -->
		<%}%>
		
<%}%>