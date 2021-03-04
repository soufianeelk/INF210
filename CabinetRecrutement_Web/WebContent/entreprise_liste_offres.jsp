<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List"%>
<%
	IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
	IServiceCandidature servicecandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
	Object utilisateur = session.getAttribute("utilisateur");

  
  if (utilisateur==null) {
	  %> 
  		<script>location.href="connexion.jsp";</script>
 	  <% 
  } else {
	  
	  Entreprise e = (Entreprise) utilisateur;
	  List<OffreEmploi> offresemploi = serviceoffreemploi.listeDesOffresPourUneEntreprise(e.getId()); 

%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des offres d'emplois référencées </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Numéro</th>
                <th>Titre</th>
                <th>Entreprise</th>
                <th>Niveau de qualification</th>
                <th>Date de dépôt</th>
                <th>Candidatures potentielles</th>
                <th>Modification</th>
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
            <form role="fprm" method="post"><%
              for(OffreEmploi offreemploi : offresemploi)
              {
                %>
               <tr>
                 <td>OFF_<%=offreemploi.getId()%></td>
                 <td><%=offreemploi.getTitre()%></td>
                 <td><%=offreemploi.getEntrepriseBean().getNom()%></td>
                 <td><%=offreemploi.getNiveauQualificationBean().getIntitule()%></td>
             	 <td><%=offreemploi.getDatedepot()%></td>
                 <td>
                    <small>
                			 <table border="0" width="100%">
                  <% for (Candidature c  : servicecandidature.findCandidatureByNiveauQualificationAndSecteurActivite(offreemploi.getId())) {%>
                            
                              
                                <tr>
                                  <td>
                                    <a href="template.jsp?action=infos_candidature&id=<%=c.getId().intValue()%>"><%=c.getPrenom()%> <%=c.getNom()%></a><br/>
                                  </td>
                                  <td >
                                    <a href="template.jsp?action=nouveau_message_offre_emploi&id_offre=<%=offreemploi.getId().intValue()%>&id_candidature=<%=c.getId().intValue()%>"><i class="fa fa-envelope"></i></a>
                                  </td>
                                </tr>
                      <%} %>
                         </table>
                     </small>
                 </td>
                 
                 <td align="center"><a href="template.jsp?action=maj_offre&id_offre=<%=offreemploi.getId()%>"><i class="fa fa-pencil-square-o fa-lg"></i></a></td>
                 <td align="center"><a href="template.jsp?action=infos_offre&id=<%=offreemploi.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                <%
              }
              %>
        		</form>
               </tr>
              
              
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
<%}%>

