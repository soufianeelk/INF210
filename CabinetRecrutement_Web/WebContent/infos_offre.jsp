<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>

<%
  String erreur = null;
  String idStringValue = request.getParameter("id");
  int id = -1;
  OffreEmploi offreemploi = null;
  
  if(idStringValue == null)
  {
    erreur="Aucun identifiant d'offreemploi n'est fourni dans la demande.";
  }
  else
  {
    try
    {
      id = new Integer(idStringValue);
      // C'est OK : on a bien un id
      IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
      offreemploi = serviceOffreEmploi.obtenirOffreEmploi(id);
      if(offreemploi == null)
      {
        erreur="Aucune offreemploi ne correspond à cet identifiant : " + id;
      }
    }
    catch(NumberFormatException e)
    {
      erreur = "La valeur de l'identifiant n'est pas numérique";
    }
  }
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur l'offreemploi</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
        if(erreur != null) // Une erreur a été détectée et est affichée.
        {
         %>
         <div class="row col-xs-offset-1 col-xs-10">
           <div class="panel panel-red">
             <div class="panel-heading ">
               Impossible de traiter la demande
             </div>
             <div class="panel-body text-center">
               <p class="text-danger"><strong><%=erreur%></strong></p>
             </div>
           </div>
         </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
         <%
         }
        else
        {
           %>
        <div class="table-responsive">
            <small>
            <table class="table">
              <tbody>
                <tr class="success">
                  <td width="200"><strong>Identifiant (login)</strong></td>
                  <td>ENT_<%=offreemploi.getId()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Titre</strong></td>
                  <td><%=offreemploi.getTitre()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Descriptif</strong></td>
                  <td><%=offreemploi.getDescriptifmission()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Profil recherché</strong></td>
                  <td><%=Utils.text2HTML(offreemploi.getProfilrecherche())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de dépôt</strong></td>
                  <td><%=Utils.text2HTML(offreemploi.getDatedepot().toString())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Niveau de Qualification</strong></td>
                  <td><%=Utils.text2HTML(offreemploi.getNiveauQualificationBean().getIntitule())%></td>
                </tr>
                 <tr class="warning">
                  <td><strong>Entreprise</strong></td>
                  <td><%=Utils.text2HTML(offreemploi.getEntrepriseBean().getNom())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Secteur(s) d'activité</strong></td>
	               		
	               		<td>
	               			<ul>
				                  <%for(SecteurActivite sA: offreemploi.getSecteurActivites()) {%>
				
				                			<li><%=sA.getIntitule()%></li>
				                <%  }%>
                			</ul>
                     	</td>
                </td> 
              </tbody>
            </table>
            </small>      
        </div>
          <%
        }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
