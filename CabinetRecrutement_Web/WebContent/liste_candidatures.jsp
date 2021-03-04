<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List,
                java.text.SimpleDateFormat,
                java.text.DateFormat"%>

<%
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-users"></i> Liste des candidatures référencées</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Identifiant</th>
                <th>Nom/prénom</th>
                <th>Adresse postale</th>
                <th>Adresse email</th>
                <th>Niveau de qualification</th>
                <th>Date de dépôt</th>
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              
               <%
               DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                
               for(Candidature candidature : candidatures)
               {
            	  String date = formatter.format(candidature.getDatedepot());
                %>
                <tr>
                 <td>CAND_<%=candidature.getId()%></td>
                 <td><%=candidature.getNom()%> <%= candidature.getPrenom() %></td>
                 <td><%=candidature.getAdressepostale()%></td>
                 <td><%=candidature.getAdresseemail()%></td>
                 <td><%=candidature.getNiveauQualificationBean().getIntitule() %></td>
                 <td><%=date%></td>
                  <td align="center"><a href="template.jsp?action=infos_candidature&id=<%=candidature.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
                <%
              }
              %>
                
            </tbody>
          </table>
        <p/>
        <div class="col-md-offset-4 col-md-4">
          <div class="alert alert-success">
            <p class="text-center">Suivre les nouvelles candidatures : <a href="cabinet_recrutement_candidatures_rss.jsp"><i class="fa fa-rss-square fa-lg"></a></i></p>
          </div>
        </div>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
