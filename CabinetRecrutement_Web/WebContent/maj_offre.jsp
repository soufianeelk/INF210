<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.HashSet,
                java.util.Date,
                java.util.Calendar,
                java.util.List"%>



<%
  IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
  List<NiveauQualification> niveauQualification = serviceIndexation.listeDesNiveauxQualification();
  List<SecteurActivite> secteurActivite = serviceIndexation.listeDesSecteursActivite();

  IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  Object utilisateur = session.getAttribute("utilisateur");
  String offreID=request.getParameter("id_offre");
  
  int i=0;
  
  
 
  if (utilisateur==null) {
	 //response.sendRedirect("connexion.jsp");
	  %> 
	  <script>location.href="connexion.jsp";</script>
	  <%
  }
  else { 
	  	

		  
		  if("GET".equals(request.getMethod())) {
			  OffreEmploi offre = serviceoffreemploi.obtenirOffreEmploi(Integer.parseInt(offreID));
			  %>
			  	<div class="row">
			  	  <div class="col-lg-12">
			  	    <div class="panel panel-default">
			  	      <div class="panel-heading"><h3><i class="fa fa-file"></i> Mise à jour d'offre d'emploi</h3></div> <!-- /.panel-heading -->
			  	      <div class="panel-body">
			  	        
			  	            <div class="col-lg-offset-2 col-lg-8
			  	                        col-xs-12">
			  	              <form role="form" action="template.jsp" method="post">
			  	                <input type="hidden" name="action" value="maj_offre" />
			  	                <input type="hidden" name="id_offre" value="<%=offreID%>" />
			  	                <div class="form-group">
			  	                  <label for="titreMission">Titre de la mission</label>
			  	                  <input class="form-control" placeholder="Titre" name="titre" value="<%=offre.getTitre()%>"/>
			  	                </div>
			  	                
			  	                <div class="form-group">
			  	                  <label for="descriptifMission">Descriptif de la mission</label>
			  	                  <textarea class="form-control" placeholder="Descriptif de la mission" rows="3" name="descriptif"><%=offre.getDescriptifmission()%></textarea>
			  	                </div>
			  	                
			  	                <div class="form-group">
			  	                  <label for="profilRecherche">Profil recherché</label>
			  	                  <input class="form-control" placeholder="Profil recherché" name="profil_recherche" value="<%=offre.getTitre()%>"/>
			  	                </div>
			  	                
			  	                <!-- Niveau de qualification --> 
			  	                
			  	                <div class="col-lg-3">
			  	 				<div class="form-group">
			  	 					<label>Niveau de qualification</label>
					  	 			<small>
					  	 			
			                   <% for(NiveauQualification niveau : niveauQualification) {
			                   
			                   		if(niveau.getId().intValue()==offre.getNiveauQualificationBean().getId().intValue()) {
			                   %>
			                   
			                        <div class="radio">
			                          <label>
			                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" checked/><%=niveau.getIntitule()%>
			                          </label>
			                        </div>
			                        <%}else{%>
			                        
				                       	<div class="radio">
				                          <label>
				                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" /><%=niveau.getIntitule()%>
				                          </label>
				                        </div>
			                        <%}%>
			                        
			      				<%}%>
			  	 					</small>
					  	 		</div>		
			  	 				</div>
			  	 				
			  	 				<!-- Secteur activité --> 
			  	 				
			  	 				<div class="col-lg-9">
			  	 					<div class="form-group">
			  	 						<label>Secteur(s) d'activité</label>
			  	 							<small>
			  	 								<table border="0" width="100%">
			  	 								
															<% 
															HashSet<SecteurActivite> listeSecteurActivite = (HashSet) offre.getSecteurActivites();
															Boolean toCheck = false;
															for (SecteurActivite sA : secteurActivite) {
																toCheck=false;
																int j = 0;
																for (SecteurActivite secteurList : listeSecteurActivite) {
																	int e = 0;
																	if(secteurList.getId().intValue()==sA.getId().intValue()) toCheck=true;
																}
																
																if (i%2 == 0) {
															%>	
										                        
										                            	<% if(toCheck) {%>
										                 			 <tr>
											                             <td>
											                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" checked /> <%=sA.getIntitule()%>
											                            </td>
											                            <%}else { %>
										                 			 <tr>
											                             <td>
											                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
											                            </td>												                            
											                            <%} %>
										                           <% i++;
										                           
																} else { %> 
																	<% if(toCheck) {%>
										                          	 	<td>
											                             	<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" checked /> <%=sA.getIntitule()%>
											                            </td>
											                         </td>
											                         <%} else { %>
											                         	<td>
											                           			<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
											                            	</td>
											                        	 </td>
											                         <%}%>
										                           <% i++;
																}%>
																<%} %>
								                            <td>&nbsp;</td>
								                            </tr>
								                            
			  	 								</table>
			  	 							</small>
			  	 					</div>		
			  	 				</div>
			  	 				
			  	 				
			  	 				
			  	                <div class="text-center">
			  	                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
			  	                  <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
			  	                </div>
			  	              </form>
			  	            </div>
			  	            
							 <div class="col-lg-12 text-center">
					              <br/>
					              <!-- Button trigger modal -->
					              <button class="btn btn-danger" data-toggle="modal" data-target="#modalSuppressionOffre">
					                <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer cette offre d'emploi
					              </button>
					              <!-- Modal -->
					              <div class="modal fade" id="modalSuppressionOffre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
					                <div class="modal-dialog">
					                  <div class="modal-content">
					                    <div class="modal-header">
					                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					                      <h4 class="modal-title" id="myModalLabel">Êtes-vous sûr de vouloir supprimer cette offre d'emploi ?</h4>
					                    </div>
					                    <div class="modal-body">
					                      Attention, cette opération n'est pas réversible !
					                    </div>
					                    <div class="modal-footer">
					                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
					                      <button type="button"
					                              class="btn btn-primary"
					                              onclick="window.location.href='suppression_offre.jsp?id_offre=<%=offre.getId().intValue()%>'">
					                        Supprimer
					                      </button>
					                    </div>
					                  </div> <!-- /.modal-content -->
					                </div> <!-- /.modal-dialog -->
					              </div> <!-- /.modal -->
					            </div>
            	  	           	           
			  	      </div> <!-- /.panel-body -->
			  	    </div> <!-- /.panel -->
			  	  </div> <!-- /.col-lg-12 -->
			  	</div> <!-- /.row -->
		  <%}else{%> <%-- ifend du GET --%> 
			  <%
				Boolean flagError = false;
			  	String titre = request.getParameter("titre"); 
			  	String descriptifMission = request.getParameter("descriptif"); 
			  	String profilRecherche = request.getParameter("profil_recherche");
				OffreEmploi offre = serviceoffreemploi.obtenirOffreEmploi(Integer.parseInt(offreID));
			  	String[] idSecteurActivite=request.getParameterValues("secteur");
			  	String idNiveauQualification = (request.getParameter("niveau"));
	
			  	if(titre.equals("") || descriptifMission.equals("") || profilRecherche.equals("")||idSecteurActivite==null) {
			  		flagError=true;	
			  	}
			  	
			  	if (flagError) { %>
			  	<div class="row">
			  	  <div class="col-lg-12">
			  	    <div class="panel panel-default">
			  	      <div class="panel-heading"><h3><i class="fa fa-file"></i> Mise à jour d'offre d'emploi</h3></div> <!-- /.panel-heading -->
			  	      <div class="panel-body">
			  	        
			  	            <div class="col-lg-offset-2 col-lg-8
			  	                        col-xs-12">
			  	              <form role="form" action="template.jsp" method="post">
			  	                <input type="hidden" name="action" value="maj_offre" />
			  	                
			  	                <div class="form-group">
					            		<label class="text-danger">Les paramètres renseignés ne sont pas corrects ! </label>   	
					             </div>
			  	                
			  	                <div class="form-group">
			  	                  <label for="titreMission">Titre de la mission</label>
			  	                  <input class="form-control" placeholder="Titre" name="titre" value="<%=offre.getTitre()%>"/>
			  	                </div>
			  	                
			  	                <div class="form-group">
			  	                  <label for="descriptifMission">Descriptif de la mission</label>
			  	                  <textarea class="form-control" placeholder="Descriptif de la mission" rows="3" name="descriptif"><%=offre.getDescriptifmission()%></textarea>
			  	                </div>
			  	                
			  	                <div class="form-group">
			  	                  <label for="profilRecherche">Profil recherché</label>
			  	                  <input class="form-control" placeholder="Profil recherché" name="profil_recherche" value="<%=offre.getTitre()%>"/>
			  	                </div>
			  	                
			  	                <!-- Niveau de qualification --> 
			  	                
			  	                <div class="col-lg-3">
			  	 				<div class="form-group">
			  	 					<label>Niveau de qualification</label>
					  	 			<small>
					  	 			
			                   <% for(NiveauQualification niveau : niveauQualification) {
			                   
			                   		if(niveau.getId().intValue()==offre.getNiveauQualificationBean().getId().intValue()) {
			                   %>
			                   
			                        <div class="radio">
			                          <label>
			                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" checked/><%=niveau.getIntitule()%>
			                          </label>
			                        </div>
			                        <%}else{%>
			                        
				                       	<div class="radio">
				                          <label>
				                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" /><%=niveau.getIntitule()%>
				                          </label>
				                        </div>
			                        <%}%>
			                        
			      				<%}%>
			  	 					</small>
					  	 		</div>		
			  	 				</div>
			  	 				
			  	 				<!-- Secteur activité --> 
			  	 				
			  	 				<div class="col-lg-9">
			  	 					<div class="form-group">
			  	 						<label>Secteur(s) d'activité</label>
			  	 							<small>
			  	 								<table border="0" width="100%">
			  	 								
															<% 
															HashSet<SecteurActivite> listeSecteurActivite = (HashSet) offre.getSecteurActivites();
															Boolean toCheck = false;
															for (SecteurActivite sA : secteurActivite) {
																toCheck=false;
																for (SecteurActivite secteurList : listeSecteurActivite) {
																	if(secteurList.getId().intValue()==sA.getId().intValue()) toCheck=true;
																}
																
																if (i%2 == 0) {
															%>	
										                        
										                            	<% if(toCheck) {%>
										                 			 <tr>
											                             <td>
											                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" checked /> <%=sA.getIntitule()%>
											                            </td>
											                            <%} else { %>
										                 			 <tr>
											                             <td>
											                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
											                            </td>												                            
											                            <%} %>
										                           <% i++;
										                           
																} else { %> 
																	<% if(toCheck) {%>
										                          	 	<td>
											                             	<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" checked /> <%=sA.getIntitule()%>
											                            </td>
											                         </td>
											                         <%} else { %>
											                         	<td>
											                           			<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
											                            	</td>
											                        	 </td>
											                         <%}%>
										                           <% i++;
																}%>
																<%} %>
								                            <td>&nbsp;</td>
								                            </tr>
								                            
			  	 								</table>
			  	 							</small>
			  	 					</div>		
			  	 				</div>
			  	 				
			  	 				
			  	 				
			  	                <div class="text-center">
			  	                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
			  	                  <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
			  	                </div>
			  	              </form>
			  	            </div>
							 <div class="col-lg-12 text-center">
					              <br/>
					              <!-- Button trigger modal -->
					              <button class="btn btn-danger" data-toggle="modal" data-target="#modalSuppressionOffre">
					                <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer cette offre d'emploi
					              </button>
					              <!-- Modal -->
					              <div class="modal fade" id="modalSuppressionOffre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
					                <div class="modal-dialog">
					                  <div class="modal-content">
					                    <div class="modal-header">
					                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					                      <h4 class="modal-title" id="myModalLabel">Êtes-vous sûr de vouloir supprimer cette offre d'emploi ?</h4>
					                    </div>
					                    <div class="modal-body">
					                      Attention, cette opération n'est pas réversible !
					                    </div>
					                    <div class="modal-footer">
					                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
					                      <button type="button"
					                              class="btn btn-primary"
					                              onclick="window.location.href='suppression_offre.jsp?id_offre=<%=offre.getId().intValue()%>'">
					                        Supprimer
					                      </button>
					                    </div>
					                  </div> <!-- /.modal-content -->
					                </div> <!-- /.modal-dialog -->
					              </div> <!-- /.modal -->
					            </div>       
			  	      </div> <!-- /.panel-body -->
			  	    </div> <!-- /.panel -->
			  	  </div> <!-- /.col-lg-12 -->
			  	</div> <!-- /.row -->			  	
			  	
			  	<%}else{%>
					<%
			  			/*HashSet<Integer>listeIdSecteurActivite = new HashSet();

					  	for(String s : idSecteurActivite) {
					  		
					  		listeIdSecteurActivite.add((Integer.parseInt(s)));

					  	}*/
					  						  	
		  		  		Entreprise e = (Entreprise) utilisateur;
                        serviceoffreemploi.miseAJourOffreEmploi(offre.getId().intValue(),descriptifMission, profilRecherche, titre, e.getId().intValue(), idNiveauQualification, idSecteurActivite);
					  	%>
					  	
						 <div class="form-group">
			  	       		<label class="text-success">Offre d'emploi modifiée avec succès !</label>
			  	        </div>
			  	
			  	<% }%> <%-- ifend du else de flagError--%>
			  	
				
			<%}%>
		
<%}%> <%-- ifend du else d'utilisateur == null --%>
