using System.Reflection;

namespace ExceptionIcon.Models
{
    public class TargetSite
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="TargetSite"/> class.
        /// </summary>
        public TargetSite()
        {

        }

        /// <summary>
        /// Initializes a new instance of the <see cref="TargetSite"/> class.
        /// </summary>
        /// <param name="methodBase">The method base.</param>
        public TargetSite(MethodBase methodBase)
            : this()
        {
            LoadTargetSite(methodBase);
        }

        /// <summary>
        /// Loads the target site.
        /// </summary>
        /// <param name="methodBase">The method base.</param>
        private void LoadTargetSite(MethodBase methodBase)
        {
            Name = methodBase.Name;
            MemberType = methodBase.MemberType;

            if (methodBase.DeclaringType != null)
            {
                DeclaringTypeName = methodBase.DeclaringType.Name;
                DeclaringTypeFullName = methodBase.DeclaringType.FullName;
            }
        }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>
        /// The name.
        /// </value>
        public string Name
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the full name of the declaring type.
        /// </summary>
        /// <value>
        /// The full name of the declaring type.
        /// </value>
        public string DeclaringTypeFullName 
        { 
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the name of the declaring type.
        /// </summary>
        /// <value>
        /// The name of the declaring type.
        /// </value>
        public string DeclaringTypeName
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the type of the member.
        /// </summary>
        /// <value>
        /// The type of the member.
        /// </value>
        public MemberTypes MemberType
        {
            get;
            set;
        }

    }
}