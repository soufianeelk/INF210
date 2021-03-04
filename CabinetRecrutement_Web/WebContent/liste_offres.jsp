<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.List"%>

<%
	IServiceOffreEmploi serviceoffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
	List<OffreEmploi> offresemploi = serviceoffreemploi.listeDesOffreEmplois();
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des offres d'emploi référencées  </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Identifiant</th>
                <th>Titre</th>
                <th>Descriptif mission</th>
                <th>Profil recherché</th>
                <th>Date de dépôt</th>
                <th>Niveau de qualification</th>
                <th>Entreprise</th>
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(OffreEmploi offreemploi : offresemploi)
              {
                %>
                <tr>
                 <td>OFF_<%=offreemploi.getId()%></td>
                 <td><%=offreemploi.getTitre()%></td>
                 <td><%=offreemploi.getDescriptifmission()%></td>
                 <td><%=offreemploi.getProfilrecherche()%></td>
             	 <td><%=offreemploi.getDatedepot()%></td>
                 <td><%=offreemploi.getNiveauQualificationBean().getIntitule()%></td>
                 <td><%=offreemploi.getEntrepriseBean().getNom()%></td>
                 <td align="center"><a href="template.jsp?action=infos_offre&id=<%=offreemploi.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
                <%
              }
              %>
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->


