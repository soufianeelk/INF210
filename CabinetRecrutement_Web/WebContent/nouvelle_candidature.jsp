<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>


<%
  IServiceCandidature serviceEntreprise = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
%>


<%
if(request.getMethod().equalsIgnoreCase("post"))
{
%>

<% 
	String nom = request.getParameter("nom");
	String prenom = request.getParameter("prenom");
	String dateNaissance = request.getParameter("dateNaissance");
	String adresse_postale = request.getParameter("adresse_postale");
	String adresse_mail = request.getParameter("adresse_mail");
	String cv = request.getParameter("cv");
	String niveauQualification = request.getParameter("niveau");
	String secteur = request.getParameter("secteur");
	
	serviceEntreprise.nouvelleCandidature(adresse_mail, adresse_postale, cv, nom, prenom, dateNaissance, niveauQualification, secteur);
}
%>


            
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Référencer une nouvelle entreprise</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="post">
                <input type="hidden" name="action" value="nouvelle_entreprise" />
                <div class="form-group">
                  <input class="form-control" placeholder="Nom" name="nom" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Prenom" rows="5" name="prenom"></textarea>
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Date de naissance" name="dateNaissance" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse Postale" name="adresse_postale" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse Email" name="adresse_mail" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Curriculum Vitae" name="cv" />
                </div><div class="col-lg-3">
                  <div class="form-group">
                    <label>Niveau de qualification</label>
                    <small>
                      
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="1" />CAP/BEP
                          </label>
                        </div>
                        
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="2" />Bac
                          </label>
                        </div>
                        
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="3" />Bac+3
                          </label>
                        </div>
                        
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="4" />Bac+5
                          </label>
                        </div>
                        
                        <div class="radio">
                          <label>
                            <input type="radio" name="niveau" value="5" />Doctorat
                          </label>
                        </div>
                        
                    </small>
                  </div>
                </div>
                <div class="col-lg-9">
                <div class="form-group">
                  <label>Secteur(s) d'activité</label>
                  <small>
                    <table border="0" width="100%">
                      <!-- Un petit système à la volée pour mettre les checkboxes en deux colonnes...  -->
                      
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="1" /> Achats/Logistique
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="2" /> Assistanat/Secrétariat
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="3" /> Agriculture
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="4" /> Agroalimentaire
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="5" /> Assurance
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="6" /> Audit/Conseil/Expertises
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="7" /> BTP/Immobilier
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="8" /> Commercial
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="9" /> Communication/Art/Média/Mode
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="10" /> Comptabilité
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="11" /> Direction Générale/Executive
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="12" /> Distribution/Commerce
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="13" /> Electronique/Microélectronique
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="14" /> Environnement
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="15" /> Finance/Banque
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="16" /> Formation/Enseignement
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="17" /> Hôtellerie/Restauration/Tourisme
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="18" /> Industrie/Ingénierie/Production
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="19" /> Informatique
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="20" /> Juridique/Fiscal/Droit
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="21" /> Marketing
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="22" /> Public/Parapublic
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="23" /> Ressources Humaines
                            </td>
                            
                            <td>
                              <input type="checkbox" name="secteur" value="24" /> Santé/Social/Biologie/Humanitaire
                            </td>
                            </tr>
                            
                            <tr>
                            <td>
                              <input type="checkbox" name="secteur" value="25" /> Télécom/Réseaux
                            </td>
                            
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