package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;

/**
 * Session Bean implementation class MessageOffreDemploiDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageOffreDemploiDAO
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
  public MessageOffreDemploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public MessageOffreDemploi findById(Integer id)
  {
    return entityManager.find(MessageOffreDemploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageOffreDemploi> findAll()
  {
    Query query = entityManager.createQuery("select messageOffreDemploi from MessageOffreDemploi messageOffreDemploi order by messageOffreDemploi.id");
    List l = query.getResultList(); 
    
    return (List<MessageOffreDemploi>)l;
  }
  //-----------------------------------------------------------------------------
  public MessageOffreDemploi persist(MessageOffreDemploi messageOffreDemploi) {
	  entityManager.persist(messageOffreDemploi);
	  return messageOffreDemploi;
  }
  
  public MessageOffreDemploi update(MessageOffreDemploi messageOffreDemploi) {
	  entityManager.merge(messageOffreDemploi);
	  return messageOffreDemploi;
  }
  
  public void remove(MessageOffreDemploi messageOffreDemploi) {
	  entityManager.remove(messageOffreDemploi);
  }

}
