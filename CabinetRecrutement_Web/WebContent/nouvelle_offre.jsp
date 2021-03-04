<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                java.util.HashSet,
                java.util.Date,
                java.util.Calendar,
                java.util.List"%>



<%
  IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
  List<NiveauQualification> niveauQualification = serviceIndexation.listeDesNiveauxQualification();
  List<SecteurActivite> secteurActivite = serviceIndexation.listeDesSecteursActivite();
  IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  Object utilisateur = session.getAttribute("utilisateur");
  int i=0;
  
 
  if (utilisateur==null) {
	 //response.sendRedirect("connexion.jsp");
	  %> 
	  <script>location.href="connexion.jsp";</script>
	  <%
  }
  else { 
			  if("GET".equals(request.getMethod())) {
				  %>
				  	<div class="row">
				  	  <div class="col-lg-12">
				  	    <div class="panel panel-default">
				  	      <div class="panel-heading"><h3><i class="fa fa-file"></i> Nouvelle offre d'emploi</h3></div> <!-- /.panel-heading -->
				  	      <div class="panel-body">
				  	        
				  	            <div class="col-lg-offset-2 col-lg-8
				  	                        col-xs-12">
				  	              <form role="form" action="template.jsp" method="post">
				  	                <input type="hidden" name="action" value="nouvelle_offre" />
				  	                
				  	                <div class="form-group">
				  	                  <label for="titreMission">Titre de la mission</label>
				  	                  <input class="form-control" placeholder="Titre" name="titre" />
				  	                </div>
				  	                
				  	                <div class="form-group">
				  	                  <label for="descriptifMission">Descriptif de la mission</label>
				  	                  <textarea class="form-control" placeholder="Descriptif de la mission" rows="3" name="descriptif"></textarea>
				  	                </div>
				  	                
				  	                <div class="form-group">
				  	                  <label for="profilRecherche">Profil recherché</label>
				  	                  <input class="form-control" placeholder="Profil recherché" name="profil_recherche" />
				  	                </div>
				  	                
				  	                <!-- Niveau de qualification --> 
				  	                
				  	                <div class="col-lg-3">
				  	 				<div class="form-group">
				  	 					<label>Niveau de qualification</label>
						  	 			<small>
						  	 			
				                   <% for(NiveauQualification niveau : niveauQualification) {%>
				                   
				                        <div class="radio">
				                          <label>
				                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" /><%=niveau.getIntitule()%>
				                          </label>
				                        </div>
				                        
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
				  	 								
																<% for (SecteurActivite sA : secteurActivite) {
																	
																	if (i%2 == 0) {
																%>	
											                            <tr>
												                             <td>
												                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
												                            </td>
											                           <% i++;
											                           
																	} else { %> 
											                           	<td>
												                             	<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
												                            </td>
												                         </td>
											                           <% i++;
																	}%>
											                     <%}%>
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
				  	           	           
				  	      </div> <!-- /.panel-body -->
				  	    </div> <!-- /.panel -->
				  	  </div> <!-- /.col-lg-12 -->
				  	</div> <!-- /.row -->
				  
		<%}else{%> <!-- ifGET -->
					<% 
						Boolean flagError = false;
					  	String titre = request.getParameter("titre"); 
					  	String descriptifMission = request.getParameter("descriptif"); 
					  	String profilRecherche = request.getParameter("profil_recherche");
					  	String[] idSecteurActivite = request.getParameterValues("secteur");
					  	String idNiveauQualification = request.getParameter("niveau");
			
					  	if(titre.equals("") || descriptifMission.equals("") || profilRecherche.equals("") || idSecteurActivite==null) {
					  		flagError=true;	
					  	}
					  	
					  	if (flagError) {
					  	%>
					  					  	<div class="row">
				  	  <div class="col-lg-12">
				  	    <div class="panel panel-default">
				  	      <div class="panel-heading"><h3><i class="fa fa-file"></i> Nouvelle offre d'emploi</h3></div> <!-- /.panel-heading -->
				  	      <div class="panel-body">
				  	        
				  	            <div class="col-lg-offset-2 col-lg-8
				  	                        col-xs-12">
				  	              <form role="form" action="template.jsp" method="post">
				  	                <input type="hidden" name="action" value="nouvelle_offre" />
				  	                
				  	          		<div class="form-group">
					            		<label class="text-danger">Les paramètres renseignés ne sont pas corrects ! </label>   	
					               </div>
				  	                
				  	                <div class="form-group">
				  	                  <label for="titreMission">Titre de la mission</label>
				  	                  <input class="form-control" placeholder="Titre" name="titre" />
				  	                </div>
				  	                
				  	                <div class="form-group">
				  	                  <label for="descriptifMission">Descriptif de la mission</label>
				  	                  <textarea class="form-control" placeholder="Descriptif de la mission" rows="3" name="descriptif"></textarea>
				  	                </div>
				  	                
				  	                <div class="form-group">
				  	                  <label for="profilRecherche">Profil recherché</label>
				  	                  <input class="form-control" placeholder="Profil recherché" name="profil_recherche" />
				  	                </div>
				  	                
				  	                <!-- Niveau de qualification --> 
				  	                
				  	                <div class="col-lg-3">
				  	 				<div class="form-group">
				  	 					<label>Niveau de qualification</label>
						  	 			<small>
						  	 			
				                   <% for(NiveauQualification niveau : niveauQualification) {%>
				                   
				                        <div class="radio">
				                          <label>
				                            <input type="radio" name="niveau" value="<%=niveau.getId().intValue()%>" /><%=niveau.getIntitule()%>
				                          </label>
				                        </div>
				                        
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
				  	 								
																<% for (SecteurActivite sA : secteurActivite) {
																	
																	if (i%2 == 0) {
																%>	
											                            <tr>
												                             <td>
												                              <input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
												                            </td>
											                           <% i++;
											                           
																	} else { %> 
											                           	<td>
												                             	<input type="checkbox" name="secteur" value="<%=sA.getId().intValue()%>" /> <%=sA.getIntitule()%>
												                            </td>
												                         </td>
											                           <% i++;
																	}%>
											                     <%}%>
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
		  	    		serviceoffreemploi.nouvelleOffreEmploi(descriptifMission, profilRecherche, titre, e.getId(), idNiveauQualification, idSecteurActivite);
		  	    	    session.setAttribute("utilisateur", serviceEntreprise.obtenirEntreprise(((Entreprise) utilisateur).getId().intValue()));
					  	%>
					  	
						 <div class="form-group">
			  	       		<label class="text-success">Offre d'emploi ajoutée avec succès !</label>
			  	        </div>
					  	
					  	<%}%>
					  	
					  	
					  	
		<%}%>
<%}%>		

