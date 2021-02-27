<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>


<%

IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
Object utilisateur = session.getAttribute("utilisateur");
Entreprise entreprise = ((Entreprise)utilisateur);
%>

<%
if(request.getMethod().equalsIgnoreCase("post"))
{
%>

<% 
	
	String nom = request.getParameter("nom");
	String descriptif = request.getParameter("descriptif");
	String adresse_postale = request.getParameter("adresse_postale");
	serviceEntreprise.miseAJourEntreprise(entreprise.getId(), nom, descriptif, adresse_postale);
	
}
%>

<% if(utilisateur == null){%>
	<jsp:forward page="connexion.jsp"/>
<%}%>


<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Mettre à jour les informations de l'entreprise</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="post">
                <input type="hidden" name="action" value="maj_entreprise" />
                <input type="hidden" name="id_entreprise" value="22" />
                <div class="form-group">
                  <input class="form-control"  value="<%= entreprise.getId() %>" disabled="disabled" />
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Nom de l'entreprise" name="nom" value="test" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="5" name="descriptif">test</textarea>
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale" value="test" />
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
                <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer cette entreprise
              </button>
              <!-- Modal -->
              <div class="modal fade" id="modalSuppressionCandidature" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h4 class="modal-title" id="myModalLabel">Êtes-vous sûr de vouloir supprimer votre entreprise<br/>et les offres d'emploi associées ?</h4>
                    </div>
                    <div class="modal-body">
                      Attention, cette opération n'est pas réversible !
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                      <button type="button"
                              class="btn btn-primary"
                              onclick="window.location.href='suppression_entreprise.jsp?id_entreprise=22'">
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

