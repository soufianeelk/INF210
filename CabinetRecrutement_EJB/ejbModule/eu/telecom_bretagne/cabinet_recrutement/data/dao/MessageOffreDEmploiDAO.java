package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;

/**
 * Session Bean implementation class MessageOffreDemploiDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageOffreDEmploiDAO
{
  //-----------------------------------------------------------------------------
  /**
   * Référence vers le gestionnaire de persistance.
   */
  @PersistenceContext
  EntityManager entityManager;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public MessageOffreDEmploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public MessageOffreDEmploi findById(Integer id)
  {
    return entityManager.find(MessageOffreDEmploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageOffreDEmploi> findAll()
  {
    Query query = entityManager.createQuery("select messageOffreDemploi from MessageOffreDemploi messageOffreDemploi order by messageOffreDemploi.id");
    List l = query.getResultList(); 
    
    return (List<MessageOffreDEmploi>)l;
  }
  //-----------------------------------------------------------------------------
  public MessageOffreDEmploi persist(MessageOffreDEmploi messageOffreDemploi) {
	  entityManager.persist(messageOffreDemploi);
	  return messageOffreDemploi;
  }
  
  public MessageOffreDEmploi update(MessageOffreDEmploi messageOffreDemploi) {
	  entityManager.merge(messageOffreDemploi);
	  return messageOffreDemploi;
  }
  
  public void remove(MessageOffreDEmploi messageOffreDemploi) {
	  if(!entityManager.contains(messageOffreDemploi)) {
		  messageOffreDemploi = entityManager.merge(messageOffreDemploi);
	  }
	  entityManager.remove(messageOffreDemploi);
  }

}
