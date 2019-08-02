using System.ComponentModel.DataAnnotations;


namespace RestServiceModel
{
    public class Message
    {
        [Required]
        public int Id { get; set; }
        [Required]
        public string message { get; set; }
    }
}
