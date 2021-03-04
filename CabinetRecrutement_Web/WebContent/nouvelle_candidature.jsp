 <%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.List"%>


<%
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
%>


<%
if(request.getMethod().equalsIgnoreCase("post"))
{
%>

<% 
	String nom = request.getParameter("nom");
	String prenom = request.getParameter("prenom");
	String dateNaissance = request.getParameter("date_naissance");
	String adresse_postale = request.getParameter("adresse_postale");
	String adresse_mail = request.getParameter("adresse_mail");
	String cv = request.getParameter("cv");
	String niveauQualification = request.getParameter("niveau");
	String[] secteur = request.getParameterValues("secteur");
	
	
	serviceCandidature.nouvelleCandidature(adresse_mail, adresse_postale, cv, nom, prenom, dateNaissance, niveauQualification, secteur);
}
%>


            
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-user"></i> Référencer une nouvelle candidature</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="post">
                <input type="hidden" name="action" value="nouvelle_candidature" />
                <div class="form-group">
                  <input class="form-control" placeholder="Nom" name="nom" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Prénom" name="prenom" />
                </div>
                <div class="form-group">
                  <input class="form-control" type="date" placeholder="Date de naissance (format jj/mm/aaaa)" name="date_naissance" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale" />
                </div>
                <div class="form-group">
                  <input class="form-control" type="email" placeholder="Adresse email" name="adresse_mail" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Curriculum vitæ" rows="5" name="cv"></textarea>
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
                            <input type="radio" name="niveau" value="<%=nQ.getId() %>" /> <%=nQ.getIntitule() %>
                          </label>
                        </div>
                        
                    <%} %>
                        
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
                              <input type="checkbox" name="secteur" value="<%= sA.getId() %>" /> <%=sA.getIntitule() %>
                            </td>
                     <%}
                     %>       
                     
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