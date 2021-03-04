<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.List"%>


<%

IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
Object utilisateur = session.getAttribute("utilisateur");
Candidature candidature = ((Candidature)utilisateur);
%>

<%
if(request.getMethod().equalsIgnoreCase("post"))
{
%>

<% 
	
	String nom = request.getParameter("nom");
	String prenom = request.getParameter("prenom");
	String date_naissance = request.getParameter("date_naissance");
	String adresse_postale = request.getParameter("adresse_postale");
	String adresse_email = request.getParameter("adresse_email");
	String cv = request.getParameter("cv");
	String niveauQualification = request.getParameter("niveau");
	String[] secteur = request.getParameterValues("secteur");
	

	serviceCandidature.miseAJourCandidature(candidature.getId(), adresse_email, adresse_postale, cv, nom, prenom, date_naissance, niveauQualification, secteur);
	
}
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-user"></i> Mettre à jour les informations de la candidature</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="post">
                <input type="hidden" name="action" value="maj_candidature" />
                <input type="hidden" name="id_candidature" value="<%= candidature.getId() %>" />
                <div class="form-group">
                  <input class="form-control"  value="CAND_<%= candidature.getId() %>" disabled="disabled" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Nom" name="nom" value="<%= candidature.getNom() %>" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Prénom" name="prenom" value="<%= candidature.getPrenom() %>" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Date de naissance (format jj/mm/aaaa)" type="date" name="date_naissance" value="<%= candidature.getDatenaissance() %>" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale" value="<%= candidature.getAdressepostale() %>" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse email" name="adresse_email" value="<%= candidature.getAdresseemail() %>" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Curriculum vitæ" rows="5" name="cv"> <%= candidature.getCv() %></textarea>
                </div>
                <div class="col-lg-3">
                  <div class="form-group">
                    <label>Niveau de qualification</label>
                    <small>
                    
                    <% 
                    for(NiveauQualification nQ: serviceIndexation.listeDesNiveauxQualification()) {
                    %>
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="<%= nQ.getId() %>" /> <%=nQ.getIntitule()%>
                          </label>
                        </div>
                    <%};
                    %>
                        
                    </small>
                  </div>
                </div>
                <div class="col-lg-9">
                <div class="form-group">
                  <label>Secteur(s) d'activité</label>
                  <small>
                    <table border="0" width="100%">
                      <!-- Un petit système à la volée pour mettre les checkboxes en deux colonnes...  -->
                      
                      <%
                      for(SecteurActivite sA: serviceIndexation.listeDesSecteursActivite()){
                      %>
                      
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="<%= sA.getId() %>"  /> <%= sA.getIntitule() %>
                            </td>
                              </tr>
                     <%}
                     %>     
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
              <button class="btn btn-danger" data-toggle="modal" data-target="#modalSuppressionCandidature">
                <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer cette candidature
              </button>
              <!-- Modal -->
              <div class="modal fade" id="modalSuppressionCandidature" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h4 class="modal-title" id="myModalLabel">Êtes-vous sûr de vouloir supprimer votre candidature ?</h4>
                    </div>
                    <div class="modal-body">
                      Attention, cette opération n'est pas réversible !
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                      <button type="button"
                              class="btn btn-primary"
                              onclick="window.location.href='suppression_candidature.jsp?id_candidature=10'">
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

