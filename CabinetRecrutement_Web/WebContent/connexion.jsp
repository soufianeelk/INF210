<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  String identifiant = request.getParameter("identifiant");
  if(identifiant == null) // Pas de paramètre "identifiant" => affichage du formulaire
  {
  	%>
<html lang="en">
  <jsp:include page="fragments/head.html" />
  <body>
    <div id="wrapper">
      <!-- Navigation -->
      <nav class="navbar
                  navbar-default
                  navbar-static-top"
           role="navigation"
           style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp" />
        <jsp:include page="fragments/menu.jsp" />
      </nav>
 
      <div id="page-wrapper">
        <p style="font-size: 5">&nbsp;</p>
        <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3><i class="fa fa-sign-in"></i> Connexion</h3>
              </div> <!-- /.panel-heading -->
              <div class="panel-body">
                
                    <div class="row col-xs-offset-2 col-xs-8">
                      <!-- Formulaire -->
                      <form role="form" action="connexion.jsp" method="get">
                        <fieldset>
                          <div class="form-group">
                            <input class="form-control" placeholder="Identifiant" name="identifiant" type="text" autofocus>
                          </div>
                          <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
                        </fieldset>
                      </form>
                      <p/>
                      <!-- Message -->
                      <div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br/>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
                    </div>
                      
                  </div> <!-- /.panel-body -->
                </div> <!-- /.panel-default -->
              </div> <!-- /.col-lg-12 -->
            </div> <!-- /.row -->
          </div> <!-- /#page-wrapper -->
        </div> <!-- /#wrapper -->
     <jsp:include page="fragments/fin_de_page.html" />
  </body>
</html>
  	<%
  }
  else                    // Paramètre "identifiant" existant => connexion
  {
  	if(identifiant.equals(""))
  	{
      %>
	  		<html lang="en">
	  <jsp:include page="fragments/head.html" />
	  <body>
	    <div id="wrapper">
	      <!-- Navigation -->
	      <nav class="navbar
	                  navbar-default
	                  navbar-static-top"
	           role="navigation"
	           style="margin-bottom: 0">
	        <jsp:include page="fragments/bandeau.jsp" />
	        <jsp:include page="fragments/menu.jsp" />
	      </nav>
	 
	      <div id="page-wrapper">
	        <p style="font-size: 5">&nbsp;</p>
	        <div class="row">
	          <div class="col-lg-12">
	            <div class="panel panel-default">
	              <div class="panel-heading">
	                <h3><i class="fa fa-sign-in"></i> Connexion</h3>
	              </div> <!-- /.panel-heading -->
	              <div class="panel-body">
	                
	                    <div class="row col-xs-offset-2 col-xs-8">
	                      <!-- Formulaire -->
	                      <form role="form" action="connexion.jsp" method="post">
	                        <div class="form-group">
		             			<label class="text-danger">L'identifiant renseigné ne peut être nul !</label>   	
		                	</div>
	                        <fieldset>
	                          <div class="form-group">
	                            <input class="form-control" placeholder="Identifiant" name="identifiant" type="text" autofocus>
	                          </div>
	                          <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
	                        </fieldset>
	                      </form>
	                      <p/>
	                      <!-- Message -->
	                      <div class="alert alert-info col-xs-offset-3 col-xs-6">
	                         L'identifiant est la clé primaire préfixée de :
	                         <ul>
	                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
	                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
	                         </ul>
	                         <br/>
	                         <em>Note : l'identification se fait sans mot de passe.</em>
	                       </div>
	                    </div>
	                      
	                  </div> <!-- /.panel-body -->
	                </div> <!-- /.panel-default -->
	              </div> <!-- /.col-lg-12 -->
	            </div> <!-- /.row -->
	          </div> <!-- /#page-wrapper -->
	        </div> <!-- /#wrapper -->
	     <jsp:include page="fragments/fin_de_page.html" />
	  </body>
	</html>
      <%
  	}
    else if(identifiant.startsWith("ENT_"))
  	{
  		IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  		int id = Integer.parseInt(identifiant.substring(4)); // On enlève le préfixe "ENT_";
  		Entreprise entreprise = serviceEntreprise.getEntreprise(id);
  		if(entreprise == null)
  		{
  			%>
		 <html lang="en">
		  <jsp:include page="fragments/head.html" />
		  <body>
		    <div id="wrapper">
		      <!-- Navigation -->
		      <nav class="navbar
		                  navbar-default
		                  navbar-static-top"
		           role="navigation"
		           style="margin-bottom: 0">
		        <jsp:include page="fragments/bandeau.jsp" />
		        <jsp:include page="fragments/menu.jsp" />
		      </nav>
		 
		      <div id="page-wrapper">
		        <p style="font-size: 5">&nbsp;</p>
		        <div class="row">
		          <div class="col-lg-12">
		            <div class="panel panel-default">
		              <div class="panel-heading">
		                <h3><i class="fa fa-sign-in"></i> Connexion</h3>
		              </div> <!-- /.panel-heading -->
		              <div class="panel-body">
		                
		                    <div class="row col-xs-offset-2 col-xs-8">
		                      <!-- Formulaire -->
		                      <form role="form" action="connexion.jsp" method="post">
		                        <div class="form-group">
			             			<label class="text-danger">Erreur : il n'y a pas d'entreprise avec cet identifiant</label>   	
			                	</div>
		                        <fieldset>
		                          <div class="form-group">
		                            <input class="form-control" placeholder="Identifiant" name="identifiant" type="text" autofocus>
		                          </div>
		                          <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
		                        </fieldset>
		                      </form>
		                      <p/>
		                      <!-- Message -->
		                      <div class="alert alert-info col-xs-offset-3 col-xs-6">
		                         L'identifiant est la clé primaire préfixée de :
		                         <ul>
		                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
		                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
		                         </ul>
		                         <br/>
		                         <em>Note : l'identification se fait sans mot de passe.</em>
		                       </div>
		                    </div>
		                      
		                  </div> <!-- /.panel-body -->
		                </div> <!-- /.panel-default -->
		              </div> <!-- /.col-lg-12 -->
		            </div> <!-- /.row -->
		          </div> <!-- /#page-wrapper -->
		        </div> <!-- /#wrapper -->
		     <jsp:include page="fragments/fin_de_page.html" />
		  </body>
		</html>
  			<%
  		}
  		else
  		{
        session.setAttribute("utilisateur",entreprise);
        response.sendRedirect("index.jsp");
  		}
  	}
  	else if(identifiant.startsWith("CAND_"))
  	{
  		IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  		int id = Integer.parseInt(identifiant.substring(5)); // On enlève le préfixe "CAND_";
  		Candidature candidature = serviceCandidature.getCandidature(id);
      if(candidature == null)
      {
        %>
 <html lang="en">
  <jsp:include page="fragments/head.html" />
  <body>
    <div id="wrapper">
      <!-- Navigation -->
      <nav class="navbar
                  navbar-default
                  navbar-static-top"
           role="navigation"
           style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp" />
        <jsp:include page="fragments/menu.jsp" />
      </nav>
 
      <div id="page-wrapper">
        <p style="font-size: 5">&nbsp;</p>
        <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3><i class="fa fa-sign-in"></i> Connexion</h3>
              </div> <!-- /.panel-heading -->
              <div class="panel-body">
                
                    <div class="row col-xs-offset-2 col-xs-8">
                      <!-- Formulaire -->
                      <form role="form" action="connexion.jsp" method="post">
                        <div class="form-group">
	             			<label class="text-danger">Erreur : il n'y a pas d'entreprise avec cet identifiant</label>   	
	                	</div>
                        <fieldset>
                          <div class="form-group">
                            <input class="form-control" placeholder="Identifiant" name="identifiant" type="text" autofocus>
                          </div>
                          <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
                        </fieldset>
                      </form>
                      <p/>
                      <!-- Message -->
                      <div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br/>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
                    </div>
                      
                  </div> <!-- /.panel-body -->
                </div> <!-- /.panel-default -->
              </div> <!-- /.col-lg-12 -->
            </div> <!-- /.row -->
          </div> <!-- /#page-wrapper -->
        </div> <!-- /#wrapper -->
     <jsp:include page="fragments/fin_de_page.html" />
  </body>
</html>
        <%
      }
      else
      {
        session.setAttribute("utilisateur",candidature);
        response.sendRedirect("index.jsp");
      }
  	}
  }
%>

