<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<% 

	Object utilisateur = session.getAttribute("utilisateur");

	if (utilisateur==null) {
		response.sendRedirect("connexion.jsp");
	
	} else {

		if(utilisateur instanceof Entreprise) {
			
			Entreprise e = (Entreprise) utilisateur;
			
			%>
			<div class="row">
			  <div class="col-lg-12">
			    <div class="panel panel-default">
			      <div class="panel-heading"><h3><i class="fa fa-envelope"></i> Liste des messages</h3></div> <!-- /.panel-heading -->
			      <div class="panel-body">
			
			        <div class="panel-group" id="accordion">
			
			          <!-- Liste des messages reçus -->
			          <div class="panel panel-default">
			            <div class="panel-heading">
			              <h4 class="panel-title">
			                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesRecus" aria-expanded="true"><i class="glyphicon glyphicon-import"></i> Message reçus</a>
			              </h4>
			            </div>
			            <div id="collapseMessagesRecus" class="panel-collapse collapse in" aria-expanded="true" style="">
			              <div class="panel-body">
			                
			                  <small>
			                    <div class="dataTable_wrapper">
			                     <table class="table table-striped table-bordered table-hover"">
			                       <thead>
			                         <tr>
			                           <th>Identifiant</th>
			                           <th>Expéditeur</th>
			                           <th>Offre</th>
			                           <th>Date d'envoi</th>
			                           <th>Message</th>
			                         </tr>
			                       </thead>
			                       <tbody>
			      					
			      					<% for (OffreEmploi offre : e.getOffreEmplois()) {
			                       			for (MessageCandidature messageCandidat : offre.getMessageCandidatures()) {
			                       				%>
			                         	<tr>
			                             <td><%=messageCandidat.getId().intValue()%></td>
			                         	 <td><a href="template.jsp?action=infos_candidature&id=<%=messageCandidat.getCandidatureBean().getId().intValue()%>"><%=messageCandidat.getCandidatureBean().getPrenom()%> <%=messageCandidat.getCandidatureBean().getNom()%></a></td>
			                             <td><a href="template.jsp?action=infos_offre&id=<%=offre.getId().intValue()%>"><%=offre.getEntrepriseBean().getNom()%></a></td>
			                             <td><%=messageCandidat.getDateenvoi().toString()%></td>
			                             <td><%=messageCandidat.getCorpsmessage()%></td>
			                           </tr>
			                           <%}
			                       			}%>
			                       </tbody>
			                       
			                       
			                     </table>
			                   </div> <!-- /.table-responsive -->
			                 </small>
			                 
			              </div>
			            </div>
			          </div>
			
			          <!-- Liste des messages envoyés -->
			          <div class="panel panel-default">
			            <div class="panel-heading">
			              <h4 class="panel-title">
			                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesEnvoyes" class="collapsed" aria-expanded="false"><i class="glyphicon glyphicon-export"></i> Messages envoyés</a>
			              </h4>
			            </div>
			            <div id="collapseMessagesEnvoyes" class="panel-collapse collapse" aria-expanded="true">
			              <div class="panel-body">
			                
			                  <small>
			                    <div class="dataTable_wrapper">
			                     <table class="table table-striped table-bordered table-hover"">
			                       <thead>
			                         <tr>
			                           <th>Identifiant</th>
			                            <th>Destinataire</th>
			                           <th>Offre</th>
			                           <th>Date d'envoi</th>
			                           <th>Message</th>
			                         </tr>
			                       </thead>
			                       <tbody>
			                         
			      					<% for (OffreEmploi offre : e.getOffreEmplois()) {
			                       			for (MessageOffreDemploi messageOffre : offre.getMessageOffreDemplois()) {
			                       				%>
			                         	<tr>
			                             <td><%=messageOffre.getId().intValue()%></td>
			                             <td><a href="template.jsp?action=infos_candidature&id=<%=messageOffre.getCandidatureBean().getId().intValue()%>"><%=messageOffre.getCandidatureBean().getPrenom()%> <%=messageOffre.getCandidatureBean().getNom()%></a></td>
			                             <td><a href="template.jsp?action=infos_offre&id=<%=offre.getId().intValue()%>"><%=offre.getEntrepriseBean().getNom()%></a></td>
			                             <td><%=messageOffre.getDateenvoi().toString()%></td>
			                             <td><%=messageOffre.getCorpsmessage()%></td>
			                           </tr>
			                           <%}
			                       			}%>
			                           
			                       </tbody>
			                     </table>
			                   </div> <!-- /.table-responsive -->
			                 </small>
			                  
			              </div>
			            </div>
			          </div>
			          
			        </div> <!-- /.panel-group -->
			
			      </div> <!-- /.panel-body -->
			    </div> <!-- /.panel -->
			  </div> <!-- /.col-lg-12 -->
			</div> <!-- /.row -->
	
	
	<%} if(utilisateur instanceof Candidature) {
	
		Candidature c = (Candidature) utilisateur;
	%>
					<div class="row">
			  <div class="col-lg-12">
			    <div class="panel panel-default">
			      <div class="panel-heading"><h3><i class="fa fa-envelope"></i> Liste des messages</h3></div> <!-- /.panel-heading -->
			      <div class="panel-body">
			
			        <div class="panel-group" id="accordion">
			
			          <!-- Liste des messages reçus -->
			          <div class="panel panel-default">
			            <div class="panel-heading">
			              <h4 class="panel-title">
			                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesRecus" aria-expanded="true"><i class="glyphicon glyphicon-import"></i> Message reçus</a>
			              </h4>
			            </div>
			            <div id="collapseMessagesRecus" class="panel-collapse collapse in" aria-expanded="true" style="">
			              <div class="panel-body">
			                
			                  <small>
			                    <div class="dataTable_wrapper">
			                     <table class="table table-striped table-bordered table-hover"">
			                       <thead>
			                         <tr>
			                           <th>Identifiant</th>
			                           <th>Expéditeur</th>
			                           <th>Offre</th>
			                           <th>Date d'envoi</th>
			                           <th>Message</th>
			                         </tr>
			                       </thead>
			                       
			                       <tbody>
			      					<% for (MessageOffreDemploi messageOffre : c.getMessageOffreDemplois()) {
			                       				%>
			                         	<tr>
			                             <td><%=messageOffre.getId().intValue()%></td>
			                         	 <td><a href="template.jsp?action=infos_entreprise&id=<%=messageOffre.getOffreEmploiBean().getId().intValue()%>"><%=messageOffre.getOffreEmploiBean().getEntrepriseBean().getNom()%></a></td>
			                             <td><a href="template.jsp?action=infos_offre&id=<%=messageOffre.getOffreEmploiBean().getId().intValue()%>"><%=messageOffre.getOffreEmploiBean().getEntrepriseBean().getNom()%></a></td>
			                             <td><%=messageOffre.getDateenvoi().toString()%></td>
			                             <td><%=messageOffre.getCorpsmessage()%></td>
			                           </tr>
			                           <%}%>
			                       </tbody>
			                       </tbody>
			                       
			                       
			                     </table>
			                   </div> <!-- /.table-responsive -->
			                 </small>
			                 
			              </div>
			            </div>
			          </div>
			
			          <!-- Liste des messages envoyés -->
			          <div class="panel panel-default">
			            <div class="panel-heading">
			              <h4 class="panel-title">
			                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesEnvoyes" class="collapsed" aria-expanded="false"><i class="glyphicon glyphicon-export"></i> Messages envoyés</a>
			              </h4>
			            </div>
			            <div id="collapseMessagesEnvoyes" class="panel-collapse collapse" aria-expanded="true">
			              <div class="panel-body">
			                
			                  <small>
			                    <div class="dataTable_wrapper">
			                     <table class="table table-striped table-bordered table-hover"">
			                       <thead>
			                         <tr>
			                           <th>Identifiant</th>
			                            <th>Destinataire</th>
			                           <th>Offre</th>
			                           <th>Date d'envoi</th>
			                           <th>Message</th>
			                         </tr>
			                       </thead>
			                       
			                       <tbody>
			      					<% for (MessageCandidature messageCandidat : c.getMessageCandidatures()) {
			                       				%>
			                         	<tr>
			                             <td><%=messageCandidat.getId().intValue()%></td>
			                         	 <td><a href="template.jsp?action=infos_entreprise&id=<%=messageCandidat.getOffreEmploiBean().getId().intValue()%>"><%=messageCandidat.getOffreEmploiBean().getEntrepriseBean().getNom()%></a></td>
			                             <td><a href="template.jsp?action=infos_offre&id=<%=messageCandidat.getOffreEmploiBean().getId().intValue()%>"><%=messageCandidat.getOffreEmploiBean().getEntrepriseBean().getNom()%></a></td>
			                             <td><%=messageCandidat.getDateenvoi().toString()%></td>
			                             <td><%=messageCandidat.getCorpsmessage()%></td>
			                           </tr>
			                           <%}%>
			                       </tbody>
			                       
			                     </table>
			                   </div> <!-- /.table-responsive -->
			                 </small>
			                  
			              </div>
			            </div>
			          </div>
			          
			        </div> <!-- /.panel-group -->
			
			      </div> <!-- /.panel-body -->
			    </div> <!-- /.panel -->
			  </div> <!-- /.col-lg-12 -->
			</div> <!-- /.row -->
	<%}%>
	
<%}%>